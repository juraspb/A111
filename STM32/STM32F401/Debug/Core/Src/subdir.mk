################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Core/Src/acc_hal_integration_single_thread_stm32cube_sparkfun_a111.c \
../Core/Src/example_service_power_bins.c \
../Core/Src/main.c \
../Core/Src/stm32f4xx_hal_msp.c \
../Core/Src/stm32f4xx_it.c \
../Core/Src/syscalls.c \
../Core/Src/sysmem.c \
../Core/Src/system_stm32f4xx.c 

OBJS += \
./Core/Src/acc_hal_integration_single_thread_stm32cube_sparkfun_a111.o \
./Core/Src/example_service_power_bins.o \
./Core/Src/main.o \
./Core/Src/stm32f4xx_hal_msp.o \
./Core/Src/stm32f4xx_it.o \
./Core/Src/syscalls.o \
./Core/Src/sysmem.o \
./Core/Src/system_stm32f4xx.o 

C_DEPS += \
./Core/Src/acc_hal_integration_single_thread_stm32cube_sparkfun_a111.d \
./Core/Src/example_service_power_bins.d \
./Core/Src/main.d \
./Core/Src/stm32f4xx_hal_msp.d \
./Core/Src/stm32f4xx_it.d \
./Core/Src/syscalls.d \
./Core/Src/sysmem.d \
./Core/Src/system_stm32f4xx.d 


# Each subdirectory must supply rules for building sources it contributes
Core/Src/acc_hal_integration_single_thread_stm32cube_sparkfun_a111.o: ../Core/Src/acc_hal_integration_single_thread_stm32cube_sparkfun_a111.c
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu99 -g3 -DUSE_HAL_DRIVER -DSTM32F401xC -DDEBUG -c -I../Drivers/CMSIS/Include -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/examples" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Core/Inc -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/integration" -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/rss/include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Core/Src/acc_hal_integration_single_thread_stm32cube_sparkfun_a111.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Core/Src/example_service_power_bins.o: ../Core/Src/example_service_power_bins.c
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu99 -g3 -DUSE_HAL_DRIVER -DSTM32F401xC -DDEBUG -c -I../Drivers/CMSIS/Include -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/examples" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Core/Inc -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/integration" -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/rss/include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Core/Src/example_service_power_bins.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Core/Src/main.o: ../Core/Src/main.c
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu99 -g3 -DUSE_HAL_DRIVER -DSTM32F401xC -DDEBUG -c -I../Drivers/CMSIS/Include -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/examples" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Core/Inc -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/integration" -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/rss/include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Core/Src/main.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Core/Src/stm32f4xx_hal_msp.o: ../Core/Src/stm32f4xx_hal_msp.c
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu99 -g3 -DUSE_HAL_DRIVER -DSTM32F401xC -DDEBUG -c -I../Drivers/CMSIS/Include -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/examples" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Core/Inc -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/integration" -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/rss/include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Core/Src/stm32f4xx_hal_msp.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Core/Src/stm32f4xx_it.o: ../Core/Src/stm32f4xx_it.c
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu99 -g3 -DUSE_HAL_DRIVER -DSTM32F401xC -DDEBUG -c -I../Drivers/CMSIS/Include -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/examples" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Core/Inc -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/integration" -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/rss/include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Core/Src/stm32f4xx_it.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Core/Src/syscalls.o: ../Core/Src/syscalls.c
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu99 -g3 -DUSE_HAL_DRIVER -DSTM32F401xC -DDEBUG -c -I../Drivers/CMSIS/Include -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/examples" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Core/Inc -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/integration" -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/rss/include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Core/Src/syscalls.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Core/Src/sysmem.o: ../Core/Src/sysmem.c
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu99 -g3 -DUSE_HAL_DRIVER -DSTM32F401xC -DDEBUG -c -I../Drivers/CMSIS/Include -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/examples" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Core/Inc -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/integration" -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/rss/include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Core/Src/sysmem.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Core/Src/system_stm32f4xx.o: ../Core/Src/system_stm32f4xx.c
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu99 -g3 -DUSE_HAL_DRIVER -DSTM32F401xC -DDEBUG -c -I../Drivers/CMSIS/Include -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/examples" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Core/Inc -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/integration" -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I"C:/Projects/Radar/A111/STM32F401/stm32cm_cut/rss/include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Core/Src/system_stm32f4xx.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

