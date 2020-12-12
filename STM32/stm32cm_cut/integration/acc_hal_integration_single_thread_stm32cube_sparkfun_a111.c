// Copyright (c) Acconeer AB, 2018-2019
// All rights reserved

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "main.h"

#include "acc_definitions.h"
#include "acc_hal_definitions.h"
#include "acc_hal_integration.h"


/* spi handle */
extern SPI_HandleTypeDef A111_SPI_HANDLE;

/**
 * @brief The number of sensors available on the board
 */
#define SENSOR_COUNT 1

/**
 * @brief Size of SPI transfer buffer
 */
#ifndef A111_SPI_MAX_TRANSFER_SIZE
#define A111_SPI_MAX_TRANSFER_SIZE 4096
#endif

/**
 * @brief The reference frequency used by this board
 *
 * This assumes 26 MHz on the Sparkfun A111 Board
 */
#define ACC_BOARD_REF_FREQ 26000000


/**
 * @brief Format for the RSS logging
 *
 */

#define LOG_FORMAT "%02u:%02u:%02u.%03u [%5u] (%c) (%s): %s\n"


/**
 * @brief Sensor states
 */
typedef enum
{
	SENSOR_STATE_UNKNOWN,
	SENSOR_STATE_READY,
	SENSOR_STATE_BUSY
} acc_hal_integration_sensor_state_t;

/**
 * @brief Sensor state collection that keeps track of current state of the sensor
 */
static acc_hal_integration_sensor_state_t sensor_state = SENSOR_STATE_UNKNOWN;


//----------------------------------------
// Implementation of RSS HAL handlers
//----------------------------------------


static void acc_hal_integration_sleep_us(uint32_t time_usec)
{
	uint32_t time_ms = time_usec / 1000;

	HAL_Delay(time_ms ? time_ms : 1);
}


static void acc_hal_integration_sensor_transfer(acc_sensor_id_t sensor_id, uint8_t *buffer, size_t buffer_size)
{
	(void)sensor_id;  // Ignore parameter sensor_id

	const uint32_t SPI_TRANSMIT_RECEIVE_TIMEOUT = 5000;

	HAL_GPIO_WritePin(A111_CS_N_GPIO_Port, A111_CS_N_Pin, GPIO_PIN_RESET);
	HAL_SPI_TransmitReceive(&A111_SPI_HANDLE, buffer, buffer, buffer_size, SPI_TRANSMIT_RECEIVE_TIMEOUT);
	HAL_GPIO_WritePin(A111_CS_N_GPIO_Port, A111_CS_N_Pin, GPIO_PIN_SET);
}


static void acc_hal_integration_sensor_power_on(acc_sensor_id_t sensor_id)
{
	(void)sensor_id;  // Ignore parameter sensor_id

	if (sensor_state == SENSOR_STATE_BUSY)
	{
		return;
	}

	HAL_GPIO_WritePin(A111_ENABLE_GPIO_Port, A111_ENABLE_Pin, GPIO_PIN_SET);
	HAL_GPIO_WritePin(A111_CS_N_GPIO_Port, A111_CS_N_Pin, GPIO_PIN_SET);

	// Wait 2 ms to make sure that the sensor crystal have time to stabilize
	acc_hal_integration_sleep_us(2000);

	sensor_state = SENSOR_STATE_BUSY;
}


static void acc_hal_integration_sensor_power_off(acc_sensor_id_t sensor_id)
{
	(void)sensor_id;  // Ignore parameter sensor_id

	if (sensor_state != SENSOR_STATE_BUSY)
	{
		return;
	}

	HAL_GPIO_WritePin(A111_CS_N_GPIO_Port, A111_CS_N_Pin, GPIO_PIN_RESET);
	HAL_GPIO_WritePin(A111_ENABLE_GPIO_Port, A111_ENABLE_Pin, GPIO_PIN_RESET);

	sensor_state = SENSOR_STATE_UNKNOWN;

	// Wait after power off to leave the sensor in a known state
	// in case the application intends to enable the sensor directly
	acc_hal_integration_sleep_us(2000);
}


static bool acc_hal_integration_wait_for_sensor_interrupt(acc_sensor_id_t sensor_id, uint32_t timeout_ms)
{
	(void)sensor_id; // Ignore parameter sensor_id

	const uint32_t wait_begin_ms = HAL_GetTick();
	while (HAL_GPIO_ReadPin(A111_SENSOR_INTERRUPT_GPIO_Port, A111_SENSOR_INTERRUPT_Pin) != GPIO_PIN_SET)
	{
		if (timeout_ms == 0 || HAL_GetTick() - wait_begin_ms > timeout_ms)
		{
			return false;
		}

		// Wait for the next tick interrupt
		__WFI();
	}

	return true;
}


static float acc_hal_integration_get_reference_frequency(void)
{
	return ACC_BOARD_REF_FREQ;
}


static uint32_t acc_hal_integration_get_current_time(void)
{
	return HAL_GetTick();
}


static void acc_hal_integration_log(acc_log_level_t level, const char *module, const char *buffer)
{
	uint32_t time_ms = acc_hal_integration_get_current_time();
	char     level_ch;

	unsigned int timestamp    = time_ms;
	unsigned int hours        = timestamp / 1000 / 60 / 60;
	unsigned int minutes      = timestamp / 1000 / 60 % 60;
	unsigned int seconds      = timestamp / 1000 % 60;
	unsigned int milliseconds = timestamp % 1000;

	level_ch = (level <= ACC_LOG_LEVEL_DEBUG) ? "EWIVD"[level] : '?';

	//printf(LOG_FORMAT, hours, minutes, seconds, milliseconds, 0, level_ch, module, buffer);
}


acc_hal_t acc_hal_integration_get_implementation(void)
{
	acc_hal_t hal =
	{
		.properties.sensor_count          = SENSOR_COUNT,
		.properties.max_spi_transfer_size = A111_SPI_MAX_TRANSFER_SIZE,

		.sensor_device.power_on                = acc_hal_integration_sensor_power_on,
		.sensor_device.power_off               = acc_hal_integration_sensor_power_off,
		.sensor_device.wait_for_interrupt      = acc_hal_integration_wait_for_sensor_interrupt,
		.sensor_device.transfer                = acc_hal_integration_sensor_transfer,
		.sensor_device.get_reference_frequency = acc_hal_integration_get_reference_frequency,

		.os.mem_alloc = malloc,
		.os.mem_free  = free,
		.os.gettime   = acc_hal_integration_get_current_time,

		.log.log_level = ACC_LOG_LEVEL_INFO,
		.log.log       = acc_hal_integration_log
	};

	return hal;
}
