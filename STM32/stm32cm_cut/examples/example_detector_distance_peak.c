// Copyright (c) Acconeer AB, 2018-2019
// All rights reserved

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "acc_base_configuration.h"
#include "acc_detector_distance_peak.h"
#include "acc_hal_integration.h"
#include "acc_hal_definitions.h"
#include "acc_rss.h"
#include "acc_version.h"

/**
 * @brief Example that shows how to use the distance peak detector
 *
 * This is an example on how the distance peak detector can be used.
 * The example executes as follows:
 *   - Activate Radar System Software (RSS)
 *   - Create a distance peak detector configuration
 *   - Create a distance peak detector using the previously created configuration
 *   - Activate the distance peak detector
 *   - Get the result and print it 5 times
 *   - Deactivate and destroy the distance peak detector
 *   - Destroy the distance peak detector configuration
 *   - Deactivate Radar System Software (RSS)
 */


#define THRESHOLD (500)


static bool execute_detection(acc_detector_distance_peak_configuration_t distance_configuration);


static void print_distances(uint16_t                                      reflection_count,
                            const acc_detector_distance_peak_reflection_t *reflections);


bool acc_example_detector_distance_peak(void)
{
	//printf("Acconeer software version %s\n", acc_version_get());

	acc_hal_t hal = acc_hal_integration_get_implementation();

	if (!acc_rss_activate(&hal))
	{
		//fprintf(stderr, "acc_rss_activate() failed\n");
		return false;
	}

	acc_detector_distance_peak_configuration_t distance_configuration = acc_detector_distance_peak_configuration_create();

	if (distance_configuration == NULL)
	{
		//fprintf(stderr, "acc_detector_distance_peak_configuration_create() failed\n");
		acc_rss_deactivate();
		return false;
	}

	// Set detector to use a fixed threshold, return absolute values for the amplitude result
	// and sort the resulting reflections on amplitude
	acc_detector_distance_peak_set_threshold_mode_fixed(distance_configuration, THRESHOLD);
	acc_detector_distance_peak_set_absolute_amplitude(distance_configuration, true);
	acc_detector_distance_peak_set_sort_by_amplitude(distance_configuration, true);

	acc_sensor_id_t sensor_id = 1;
	float           start_m   = 0.2f;
	float           length_m  = 0.5f;

	acc_base_configuration_t base_configuration = acc_detector_distance_peak_get_base_configuration(distance_configuration);

	acc_base_configuration_sensor_set(base_configuration, sensor_id);
	acc_base_configuration_requested_start_set(base_configuration, start_m);
	acc_base_configuration_requested_length_set(base_configuration, length_m);

	if (!execute_detection(distance_configuration))
	{
		acc_detector_distance_peak_configuration_destroy(&distance_configuration);
		acc_rss_deactivate();
		return false;
	}

	acc_detector_distance_peak_configuration_destroy(&distance_configuration);

	acc_rss_deactivate();

	return true;
}


bool execute_detection(acc_detector_distance_peak_configuration_t distance_configuration)
{
	acc_detector_distance_peak_handle_t handle = acc_detector_distance_peak_create(distance_configuration);

	if (handle == NULL)
	{
		//fprintf(stderr, "acc_detector_distance_peak_create() failed\n");
		return false;
	}

	acc_detector_distance_peak_metadata_t   metadata;
	uint16_t                                reflection_count_max = 5;
	acc_detector_distance_peak_reflection_t reflections[reflection_count_max];

	acc_detector_distance_peak_get_metadata(handle, &metadata);

	//printf("Start: %u mm\n", (unsigned int)(metadata.start_m * 1000.0f));
	//printf("Length: %u mm\n", (unsigned int)(metadata.length_m * 1000.0f));
	//printf("Threshold: %u\n", (unsigned int)THRESHOLD);
	//printf("\n");

	acc_detector_distance_peak_result_info_t result_info;

	if (!acc_detector_distance_peak_activate(handle))
	{
		//fprintf(stderr, "acc_detector_distance_peak_activate() failed\n");
		acc_detector_distance_peak_destroy(&handle);
		return false;
	}

	bool      success    = true;
	const int iterations = 5;

	for (int i = 0; i < iterations; i++)
	{
		uint16_t reflection_count = reflection_count_max;

		success = acc_detector_distance_peak_get_next(handle,
		                                              reflections,
		                                              &reflection_count,
		                                              &result_info);

		if (!success)
		{
			//fprintf(stderr, "acc_detector_distance_peak_get_next() failed\n");
			break;
		}

		print_distances(reflection_count, reflections);
	}

	bool deactivated = acc_detector_distance_peak_deactivate(handle);

	acc_detector_distance_peak_destroy(&handle);

	return deactivated && success;
}


void print_distances(uint16_t                                      reflection_count,
                     const acc_detector_distance_peak_reflection_t *reflections)
{
	if (reflection_count == 0)
	{
		//printf("No peaks above threshold\n");
	}
	else
	{
		for (uint16_t i = 0; i < reflection_count; i++)
		{
			unsigned int distance  = (unsigned int)((reflections[i].distance * 1000.0f) + 0.5f);
			unsigned int amplitude = (unsigned int)(reflections[i].amplitude);

			//printf("Peak %d, Distance: %3u mm, Amplitude: %u\n", i + 1, distance, amplitude);
		}
	}

	//printf("\n");
}
