################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../EMBOCON_DataTypes.c \
../EMBOCON_ModelInterface.c 

OBJS += \
./EMBOCON_DataTypes.o \
./EMBOCON_ModelInterface.o 

C_DEPS += \
./EMBOCON_DataTypes.d \
./EMBOCON_ModelInterface.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -fPIC -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


