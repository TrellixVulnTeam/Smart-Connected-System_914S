/* Automatically generated file; DO NOT EDIT */
/* Espressif IoT Development Framework Linker Script */
/* Generated from: /Users/user/esp/esp-idf/components/esp32/ld/esp32.project.ld.in */

/*  Default entry point:  */
ENTRY(call_start_cpu0);

SECTIONS
{
  /* RTC fast memory holds RTC wake stub code,
     including from any source file named rtc_wake_stub*.c
  */
  .rtc.text :
  {
    . = ALIGN(4);

    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .rtc.literal EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .rtc.text EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .rtc.text.*)
    *libfreertos.a:queue.*( .rtc.text.*)
    *libfreertos.a:queue.*(.rtc.text.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .rtc.literal  .rtc.text  .rtc.text.*)

    *rtc_wake_stub*.*(.literal .text .literal.* .text.*)
    _rtc_text_end = ABSOLUTE(.);
  } > rtc_iram_seg

  /*
    This section is required to skip rtc.text area because rtc_iram_seg and
    rtc_data_seg are reflect the same address space on different buses.
  */
  .rtc.dummy :
  {
    _rtc_dummy_start = ABSOLUTE(.);
    _rtc_fast_start = ABSOLUTE(.);
    . = SIZEOF(.rtc.text);
    _rtc_dummy_end = ABSOLUTE(.);
  } > rtc_data_seg

  /* This section located in RTC FAST Memory area.
     It holds data marked with RTC_FAST_ATTR attribute.
     See the file "esp_attr.h" for more information.
  */
  .rtc.force_fast :
  {
    . = ALIGN(4);
    _rtc_force_fast_start = ABSOLUTE(.);
    
    _coredump_rtc_fast_start = ABSOLUTE(.);
    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .rtc.fast.coredump EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .rtc.fast.coredump.*)
    *libfreertos.a:queue.*( .rtc.fast.coredump.*)
    *libfreertos.a:queue.*(.rtc.fast.coredump.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .rtc.fast.coredump  .rtc.fast.coredump.*)
    _coredump_rtc_fast_end = ABSOLUTE(.);
    
    *(.rtc.force_fast .rtc.force_fast.*)
    . = ALIGN(4) ;

    _rtc_force_fast_end = ABSOLUTE(.);
  } > rtc_data_seg

  /* RTC data section holds RTC wake stub
     data/rodata, including from any source file
     named rtc_wake_stub*.c and the data marked with
     RTC_DATA_ATTR, RTC_RODATA_ATTR attributes.
     The memory location of the data is dependent on
     CONFIG_ESP32_RTCDATA_IN_FAST_MEM option.
  */
  .rtc.data :
  {
    _rtc_data_start = ABSOLUTE(.);

    /* coredump mapping */
    _coredump_rtc_start = ABSOLUTE(.);
    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .rtc.coredump EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .rtc.coredump.*)
    *libfreertos.a:queue.*( .rtc.coredump.*)
    *libfreertos.a:queue.*(.rtc.coredump.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .rtc.coredump  .rtc.coredump.*)
    _coredump_rtc_end = ABSOLUTE(.);

    /* should be placed after coredump mapping */
    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .rtc.data EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .rtc.data.* EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .rtc.rodata EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .rtc.rodata.*)
    *libfreertos.a:queue.*( .rtc.data.*  .rtc.rodata.*)
    *libfreertos.a:queue.*(.rtc.data.xQueueGenericCreateStatic .rtc.rodata.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .rtc.data  .rtc.data.*  .rtc.rodata  .rtc.rodata.*)
    
    *rtc_wake_stub*.*(.data .rodata .data.* .rodata.* .bss .bss.*)
    _rtc_data_end = ABSOLUTE(.);
    
  } > rtc_data_location

  /* RTC bss, from any source file named rtc_wake_stub*.c */
  .rtc.bss (NOLOAD) :
  {
    _rtc_bss_start = ABSOLUTE(.);
    *rtc_wake_stub*.*(.bss .bss.*)
    *rtc_wake_stub*.*(COMMON)

    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .rtc.bss)
    *libsoc.a:uart_hal_iram.*( .rtc.bss)

    _rtc_bss_end = ABSOLUTE(.);
  } > rtc_data_location

  /* This section holds data that should not be initialized at power up
     and will be retained during deep sleep.
     User data marked with RTC_NOINIT_ATTR will be placed
     into this section. See the file "esp_attr.h" for more information.
	 The memory location of the data is dependent on
     CONFIG_ESP32_RTCDATA_IN_FAST_MEM option.
  */
  .rtc_noinit (NOLOAD):
  {
    . = ALIGN(4);
    _rtc_noinit_start = ABSOLUTE(.);
    *(.rtc_noinit .rtc_noinit.*)
    . = ALIGN(4) ;
    _rtc_noinit_end = ABSOLUTE(.);
  } > rtc_data_location

  /* This section located in RTC SLOW Memory area.
     It holds data marked with RTC_SLOW_ATTR attribute.
     See the file "esp_attr.h" for more information.
  */
  .rtc.force_slow :
  {
    . = ALIGN(4);
    _rtc_force_slow_start = ABSOLUTE(.);
    *(.rtc.force_slow .rtc.force_slow.*)
    . = ALIGN(4) ;
    _rtc_force_slow_end = ABSOLUTE(.);
  } > rtc_slow_seg

  /* Get size of rtc slow data based on rtc_data_location alias */
  _rtc_slow_length = (ORIGIN(rtc_slow_seg) == ORIGIN(rtc_data_location))
                        ? (_rtc_force_slow_end - _rtc_data_start)
                        : (_rtc_force_slow_end - _rtc_force_slow_start);

  _rtc_fast_length = (ORIGIN(rtc_slow_seg) == ORIGIN(rtc_data_location))
                        ? (_rtc_force_fast_end - _rtc_fast_start)
                        : (_rtc_noinit_end - _rtc_fast_start);

  ASSERT((_rtc_slow_length <= LENGTH(rtc_slow_seg)),
          "RTC_SLOW segment data does not fit.")

  ASSERT((_rtc_fast_length <= LENGTH(rtc_data_seg)),
          "RTC_FAST segment data does not fit.")

  /* Send .iram0 code to iram */
  .iram0.vectors :
  {
    _iram_start = ABSOLUTE(.);
    /* Vectors go to IRAM */
    _init_start = ABSOLUTE(.);
    /* Vectors according to builds/RF-2015.2-win32/esp108_v1_2_s5_512int_2/config.html */
    . = 0x0;
    KEEP(*(.WindowVectors.text));
    . = 0x180;
    KEEP(*(.Level2InterruptVector.text));
    . = 0x1c0;
    KEEP(*(.Level3InterruptVector.text));
    . = 0x200;
    KEEP(*(.Level4InterruptVector.text));
    . = 0x240;
    KEEP(*(.Level5InterruptVector.text));
    . = 0x280;
    KEEP(*(.DebugExceptionVector.text));
    . = 0x2c0;
    KEEP(*(.NMIExceptionVector.text));
    . = 0x300;
    KEEP(*(.KernelExceptionVector.text));
    . = 0x340;
    KEEP(*(.UserExceptionVector.text));
    . = 0x3C0;
    KEEP(*(.DoubleExceptionVector.text));
    . = 0x400;
    _invalid_pc_placeholder = ABSOLUTE(.);
    *(.*Vector.literal)

    *(.UserEnter.literal);
    *(.UserEnter.text);
    . = ALIGN (16);
    *(.entry.text)
    *(.init.literal)
    *(.init)

    _init_end = ABSOLUTE(.);
  } > iram0_0_seg

  .iram0.text :
  {
    /* Code marked as runnning out of IRAM */
    _iram_text_start = ABSOLUTE(.);

    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .iram1 EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .iram1.*)
    *libapp_trace.a:SEGGER_RTT_esp32.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:SEGGER_SYSVIEW.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:app_trace.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:app_trace_util.*( .literal  .literal.*  .text  .text.*)
    *libesp_common.a:esp_err.*( .literal  .literal.*  .text  .text.*)
    *libesp_event.a:default_event_loop.*(.literal.esp_event_isr_post .text.esp_event_isr_post)
    *libesp_event.a:esp_event.*(.literal.esp_event_isr_post_to .text.esp_event_isr_post_to)
    *libesp_ringbuf.a:( .literal  .literal.*  .text  .text.*)
    *libesp_system.a:panic.*( .literal  .literal.*  .text  .text.*)
    *libesp_system.a:panic_handler.*( .literal  .literal.*  .text  .text.*)
    *libesp_system.a:reset_reason.*( .literal  .literal.*  .text  .text.*)
    *libesp_system.a:system_api.*(.literal.esp_system_abort .text.esp_system_abort)
    *libfreertos.a:( .literal EXCLUDE_FILE(*libfreertos.a:queue.*) .literal.*  .text EXCLUDE_FILE(*libfreertos.a:queue.*) .text.*)
    *libfreertos.a:queue.*( .iram1.* .literal.prvIsQueueFull .literal.prvCopyDataToQueue .literal.prvNotifyQueueSetContainer .literal.prvCopyDataFromQueue .literal.xQueueGenericReset .literal.prvInitialiseNewQueue .literal.xQueueGenericCreate .literal.xQueueGetMutexHolder .literal.xQueueCreateCountingSemaphore .literal.xQueueGenericSend .literal.prvInitialiseMutex .literal.xQueueCreateMutex .literal.xQueueGiveMutexRecursive .literal.xQueueGenericSendFromISR .literal.xQueueGiveFromISR .literal.xQueueGenericReceive .literal.xQueueTakeMutexRecursive .literal.xQueueReceiveFromISR .literal.xQueuePeekFromISR .literal.uxQueueMessagesWaiting .literal.uxQueueSpacesAvailable .literal.uxQueueMessagesWaitingFromISR .literal.vQueueDelete .literal.xQueueIsQueueEmptyFromISR .literal.xQueueIsQueueFullFromISR .literal.vQueueWaitForMessageRestricted .literal.xQueueCreateSet .literal.xQueueAddToSet .literal.xQueueRemoveFromSet .literal.xQueueSelectFromSet .literal.xQueueSelectFromSetFromISR .text.prvIsQueueEmpty .text.prvIsQueueFull .text.prvCopyDataToQueue .text.prvNotifyQueueSetContainer .text.prvCopyDataFromQueue .text.xQueueGenericReset .text.prvInitialiseNewQueue .text.xQueueGenericCreate .text.xQueueGetMutexHolder .text.xQueueCreateCountingSemaphore .text.xQueueGenericSend .text.prvInitialiseMutex .text.xQueueCreateMutex .text.xQueueGiveMutexRecursive .text.xQueueGenericSendFromISR .text.xQueueGiveFromISR .text.xQueueGenericReceive .text.xQueueTakeMutexRecursive .text.xQueueReceiveFromISR .text.xQueuePeekFromISR .text.uxQueueMessagesWaiting .text.uxQueueSpacesAvailable .text.uxQueueMessagesWaitingFromISR .text.vQueueDelete .text.xQueueIsQueueEmptyFromISR .text.xQueueIsQueueFullFromISR .text.vQueueWaitForMessageRestricted .text.xQueueCreateSet .text.xQueueAddToSet .text.xQueueRemoveFromSet .text.xQueueSelectFromSet .text.xQueueSelectFromSetFromISR)
    *libfreertos.a:queue.*(.iram1.xQueueGenericCreateStatic)
    *libgcc.a:_divsf3.*( .literal  .literal.*  .text  .text.*)
    *libgcc.a:lib2funcs.*( .literal  .literal.*  .text  .text.*)
    *libgcov.a:( .literal  .literal.*  .text  .text.*)
    *libhal.a:( .literal  .literal.*  .text  .text.*)
    *libheap.a:multi_heap.*( .literal  .literal.*  .text  .text.*)
    *libheap.a:multi_heap_poisoning.*( .literal  .literal.*  .text  .text.*)
    *liblog.a:log.*(.literal.esp_log_write .text.esp_log_write)
    *liblog.a:log_freertos.*(.literal.esp_log_early_timestamp .text.esp_log_early_timestamp)
    *liblog.a:log_freertos.*(.literal.esp_log_impl_lock .text.esp_log_impl_lock)
    *liblog.a:log_freertos.*(.literal.esp_log_impl_lock_timeout .text.esp_log_impl_lock_timeout)
    *liblog.a:log_freertos.*(.literal.esp_log_impl_unlock .text.esp_log_impl_unlock)
    *liblog.a:log_freertos.*(.literal.esp_log_timestamp .text.esp_log_timestamp)
    *libnet80211.a:( .wifi0iram  .wifi0iram.*)
    *libnet80211.a:( .wifirxiram  .wifirxiram.*)
    *libnewlib.a:abort.*( .literal  .literal.*  .text  .text.*)
    *libnewlib.a:heap.*( .literal  .literal.*  .text  .text.*)
    *libpp.a:( .wifi0iram  .wifi0iram.*)
    *libpp.a:( .wifirxiram  .wifirxiram.*)
    *librtc.a:( .literal  .literal.*  .text  .text.*)
    *libsoc.a:cpu_hal.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:cpu_util.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:i2c_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:ledc_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:lldesc.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_clk.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_periph.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_pm.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_sleep.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_time.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_wdt.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:soc_hal.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:spi_flash_hal_gpspi.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:spi_flash_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:spi_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:spi_slave_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:systimer_hal.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:uart_hal_iram.*( .iram1  .iram1.*)
    *libsoc.a:wdt_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_init.*(.literal.rtc_vddsdio_set_config .text.rtc_vddsdio_set_config)
    *libspi_flash.a:memspi_host_driver.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_chip_gd.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_chip_generic.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_chip_issi.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_chip_mxic.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_rom_patch.*( .literal  .literal.*  .text  .text.*)
    *libxtensa.a:eri.*( .literal  .literal.*  .text  .text.*)
    *libxtensa.a:stdatomic.*( .literal  .literal.*  .text  .text.*)

  } > iram0_0_seg

  .dram0.data :
  {
    _data_start = ABSOLUTE(.);
    _bt_data_start = ABSOLUTE(.);
    *libbt.a:(.data .data.*)
    . = ALIGN (4);
    _bt_data_end = ABSOLUTE(.);
    _btdm_data_start = ABSOLUTE(.);
    *libbtdm_app.a:(.data .data.*)
    . = ALIGN (4);
    _btdm_data_end = ABSOLUTE(.);
    _nimble_data_start = ABSOLUTE(.);
    *libnimble.a:(.data .data.*)
    . = ALIGN (4);
    _nimble_data_end = ABSOLUTE(.);
    *(.gnu.linkonce.d.*)
    *(.data1)
    *(.sdata)
    *(.sdata.*)
    *(.gnu.linkonce.s.*)
    *(.sdata2)
    *(.sdata2.*)
    *(.gnu.linkonce.s2.*)
    *(.jcr)

    /* coredump mapping */
    _coredump_dram_start = ABSOLUTE(.);
    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .dram1.coredump EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .dram1.coredump.*)
    *libfreertos.a:queue.*( .dram1.coredump.*)
    *libfreertos.a:queue.*(.dram1.coredump.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .dram1.coredump  .dram1.coredump.*)
    _coredump_dram_end = ABSOLUTE(.);
    
    /* should be placed after coredump mapping */
    _esp_system_init_fn_array_start = ABSOLUTE(.);
    KEEP (*(SORT(.esp_system_init_fn) SORT(.esp_system_init_fn.*)))
    _esp_system_init_fn_array_end = ABSOLUTE(.);

    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .data EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .data.* EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .dram1 EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .dram1.*)
    *libapp_trace.a:SEGGER_RTT_esp32.*( .rodata  .rodata.*)
    *libapp_trace.a:SEGGER_SYSVIEW.*( .rodata  .rodata.*)
    *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.*( .rodata  .rodata.*)
    *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.*( .rodata  .rodata.*)
    *libapp_trace.a:app_trace.*( .rodata  .rodata.*)
    *libapp_trace.a:app_trace_util.*( .rodata  .rodata.*)
    *libesp_common.a:esp_err.*( .rodata  .rodata.*)
    *libesp_event.a:default_event_loop.*(.rodata.esp_event_isr_post)
    *libesp_event.a:esp_event.*(.rodata.esp_event_isr_post_to)
    *libesp_system.a:panic.*( .rodata  .rodata.*)
    *libesp_system.a:panic_handler.*( .rodata  .rodata.*)
    *libesp_system.a:reset_reason.*( .rodata  .rodata.*)
    *libesp_system.a:system_api.*(.rodata.esp_system_abort)
    *libfreertos.a:queue.*( .data.*  .dram1.*)
    *libfreertos.a:queue.*(.data.xQueueGenericCreateStatic .dram1.xQueueGenericCreateStatic)
    *libgcc.a:_divsf3.*( .rodata  .rodata.*)
    *libgcov.a:( .rodata  .rodata.*)
    *libheap.a:multi_heap.*( .rodata  .rodata.*)
    *libheap.a:multi_heap_poisoning.*( .rodata  .rodata.*)
    *liblog.a:log.*(.rodata.esp_log_write)
    *liblog.a:log_freertos.*(.rodata.esp_log_early_timestamp)
    *liblog.a:log_freertos.*(.rodata.esp_log_impl_lock)
    *liblog.a:log_freertos.*(.rodata.esp_log_impl_lock_timeout)
    *liblog.a:log_freertos.*(.rodata.esp_log_impl_unlock)
    *liblog.a:log_freertos.*(.rodata.esp_log_timestamp)
    *libnewlib.a:abort.*( .rodata  .rodata.*)
    *libnewlib.a:heap.*( .rodata  .rodata.*)
    *libphy.a:( .rodata  .rodata.*)
    *libsoc.a:cpu_hal.*( .rodata  .rodata.*)
    *libsoc.a:i2c_hal_iram.*( .rodata  .rodata.*)
    *libsoc.a:ledc_hal_iram.*( .rodata  .rodata.*)
    *libsoc.a:lldesc.*( .rodata  .rodata.*)
    *libsoc.a:rtc_clk.*( .rodata  .rodata.*)
    *libsoc.a:soc_hal.*( .rodata  .rodata.*)
    *libsoc.a:spi_flash_hal_gpspi.*( .rodata  .rodata.*)
    *libsoc.a:spi_flash_hal_iram.*( .rodata  .rodata.*)
    *libsoc.a:spi_hal_iram.*( .rodata  .rodata.*)
    *libsoc.a:spi_slave_hal_iram.*( .rodata  .rodata.*)
    *libsoc.a:systimer_hal.*( .rodata  .rodata.*)
    *libsoc.a:uart_hal_iram.*( .data  .data.*  .dram1  .dram1.*)
    *libsoc.a:wdt_hal_iram.*( .rodata  .rodata.*)
    *libsoc.a:rtc_init.*(.rodata.rtc_vddsdio_set_config)
    *libspi_flash.a:memspi_host_driver.*( .rodata  .rodata.*)
    *libspi_flash.a:spi_flash_chip_gd.*( .rodata  .rodata.*)
    *libspi_flash.a:spi_flash_chip_generic.*( .rodata  .rodata.*)
    *libspi_flash.a:spi_flash_chip_issi.*( .rodata  .rodata.*)
    *libspi_flash.a:spi_flash_chip_mxic.*( .rodata  .rodata.*)
    *libspi_flash.a:spi_flash_rom_patch.*( .rodata  .rodata.*)
    *libxtensa.a:stdatomic.*( .rodata  .rodata.*)

    _data_end = ABSOLUTE(.);
    . = ALIGN(4);
  } > dram0_0_seg

  /*This section holds data that should not be initialized at power up.
    The section located in Internal SRAM memory region. The macro _NOINIT
    can be used as attribute to place data into this section.
    See the esp_attr.h file for more information.
  */
  .noinit (NOLOAD):
  {
    . = ALIGN(4);
    _noinit_start = ABSOLUTE(.);
    *(.noinit .noinit.*)
    . = ALIGN(4) ;
    _noinit_end = ABSOLUTE(.);
  } > dram0_0_seg

  /* Shared RAM */
  .dram0.bss (NOLOAD) :
  {
    . = ALIGN (8);
    _bss_start = ABSOLUTE(.);
    *(.ext_ram.bss*)
    _bt_bss_start = ABSOLUTE(.);
    *libbt.a:(.bss .bss.* COMMON)
    . = ALIGN (4);
    _bt_bss_end = ABSOLUTE(.);
    _btdm_bss_start = ABSOLUTE(.);
    *libbtdm_app.a:(.bss .bss.* COMMON)
    . = ALIGN (4);
    _btdm_bss_end = ABSOLUTE(.);
    _nimble_bss_start = ABSOLUTE(.);
    *libnimble.a:(.bss .bss.* COMMON)
    . = ALIGN (4);
    _nimble_bss_end = ABSOLUTE(.);

    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .bss EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .bss.* EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) COMMON)
    *libfreertos.a:queue.*( .bss.*)
    *libfreertos.a:queue.*(.bss.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .bss  .bss.*  COMMON)

    *(.dynsbss)
    *(.sbss)
    *(.sbss.*)
    *(.gnu.linkonce.sb.*)
    *(.scommon)
    *(.sbss2)
    *(.sbss2.*)
    *(.gnu.linkonce.sb2.*)
    *(.dynbss)
    *(.share.mem)
    *(.gnu.linkonce.b.*)

    . = ALIGN (8);
    _bss_end = ABSOLUTE(.);
  } > dram0_0_seg

  ASSERT(((_bss_end - ORIGIN(dram0_0_seg)) <= LENGTH(dram0_0_seg)),
          "DRAM segment data does not fit.")

  /* When modifying the alignment, update tls_section_alignment in pxPortInitialiseStack */
  .flash.rodata : ALIGN(0x10)
  {
    _rodata_start = ABSOLUTE(.);

    *(.rodata_desc .rodata_desc.*)               /* Should be the first.  App version info.        DO NOT PUT ANYTHING BEFORE IT! */
    *(.rodata_custom_desc .rodata_custom_desc.*) /* Should be the second. Custom app version info. DO NOT PUT ANYTHING BEFORE IT! */

    *(EXCLUDE_FILE(*libgcov.a *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW.* *libgcc.a:_divsf3.* *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libesp_system.a:reset_reason.* *libesp_system.a:panic_handler.* *libesp_system.a:panic.* *libesp_common.a:esp_err.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_gd.* *libsoc.a:systimer_hal.* *libsoc.a:spi_hal_iram.* *libsoc.a:i2c_hal_iram.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:uart_hal_iram.* *libsoc.a:soc_hal.* *libsoc.a:cpu_hal.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_clk.* *libsoc.a:ledc_hal_iram.* *libsoc.a:wdt_hal_iram.* *libsoc.a:lldesc.* *libsoc.a:spi_flash_hal_gpspi.* *libxtensa.a:stdatomic.* *libnewlib.a:heap.* *libnewlib.a:abort.* *libphy.a) .rodata EXCLUDE_FILE(*libgcov.a *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW.* *liblog.a:log_freertos.* *liblog.a:log.* *libgcc.a:_divsf3.* *libesp_event.a:esp_event.* *libesp_event.a:default_event_loop.* *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libesp_system.a:system_api.* *libesp_system.a:reset_reason.* *libesp_system.a:panic_handler.* *libesp_system.a:panic.* *libesp_common.a:esp_err.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_gd.* *libsoc.a:rtc_init.* *libsoc.a:systimer_hal.* *libsoc.a:spi_hal_iram.* *libsoc.a:i2c_hal_iram.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:uart_hal_iram.* *libsoc.a:soc_hal.* *libsoc.a:cpu_hal.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_clk.* *libsoc.a:ledc_hal_iram.* *libsoc.a:wdt_hal_iram.* *libsoc.a:lldesc.* *libsoc.a:spi_flash_hal_gpspi.* *libxtensa.a:stdatomic.* *libnewlib.a:heap.* *libnewlib.a:abort.* *libfreertos.a:queue.* *libphy.a) .rodata.*)
    *libesp_event.a:default_event_loop.*(.rodata.esp_event_loop_create_default.str1.4 .rodata.esp_event_send_to_default_loop)
    *libesp_event.a:esp_event.*(.rodata.handler_instances_add.str1.4 .rodata.base_node_add_handler.str1.4 .rodata.loop_node_add_handler.str1.4 .rodata.esp_event_loop_create.str1.4 .rodata.esp_event_loop_run.str1.4 .rodata.esp_event_loop_run_task.str1.4 .rodata.esp_event_handler_register_with_internal.str1.4 .rodata.esp_event_handler_unregister_with_internal.str1.4 .rodata.__func__$8952 .rodata.__func__$8939 .rodata.__func__$8906 .rodata.__func__$8874 .rodata.__func__$8849 .rodata.__func__$8808 .rodata.__func__$8799)
    *libesp_system.a:system_api.*(.rodata.esp_get_idf_version.str1.4)
    *libfreertos.a:queue.*(.rodata.prvNotifyQueueSetContainer.str1.4 .rodata.xQueueGenericReset.str1.4 .rodata.__FUNCTION__$5273 .rodata.__FUNCTION__$5263 .rodata.__FUNCTION__$5243 .rodata.__FUNCTION__$5238 .rodata.__FUNCTION__$5232 .rodata.__FUNCTION__$5226 .rodata.__FUNCTION__$5220 .rodata.__FUNCTION__$5211 .rodata.__FUNCTION__$5201 .rodata.__FUNCTION__$5190 .rodata.__FUNCTION__$5182 .rodata.__FUNCTION__$5309 .rodata.__FUNCTION__$5171 .rodata.__FUNCTION__$5160 .rodata.__FUNCTION__$5154 .rodata.__FUNCTION__$5147 .rodata.__FUNCTION__$5120 .rodata.__func__$4318 .rodata.__FUNCTION__$5111)
    *libfreertos.a:queue.*(.rodata.xQueueGenericCreateStatic)
    *liblog.a:log.*(.rodata.esp_log_level_set.str1.4 .rodata.__func__$3544 .rodata.__func__$3515)
    *liblog.a:log_freertos.*(.rodata.esp_log_system_timestamp.str1.4)
    *libsoc.a:rtc_init.*( .rodata.*)
    *libsoc.a:uart_hal_iram.*( .rodata  .rodata.*)


    *(.irom1.text) /* catch stray ICACHE_RODATA_ATTR */
    *(.gnu.linkonce.r.*)
    *(.rodata1)
    __XT_EXCEPTION_TABLE_ = ABSOLUTE(.);
    *(.xt_except_table)
    *(.gcc_except_table .gcc_except_table.*)
    *(.gnu.linkonce.e.*)
    *(.gnu.version_r)
    . = (. + 3) & ~ 3;
    __eh_frame = ABSOLUTE(.);
    KEEP(*(.eh_frame))
    . = (. + 7) & ~ 3;
    /*  C++ constructor and destructor tables

        Make a point of not including anything from crtbegin.o or crtend.o, as IDF doesn't use toolchain crt
      */
    __init_array_start = ABSOLUTE(.);
    KEEP (*(EXCLUDE_FILE (*crtend.* *crtbegin.*) .ctors SORT(.ctors.*)))
    __init_array_end = ABSOLUTE(.);

    KEEP (*crtbegin.*(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.*) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
    /*  C++ exception handlers table:  */
    __XT_EXCEPTION_DESCS_ = ABSOLUTE(.);
    *(.xt_except_desc)
    *(.gnu.linkonce.h.*)
    __XT_EXCEPTION_DESCS_END__ = ABSOLUTE(.);
    *(.xt_except_desc_end)
    *(.dynamic)
    *(.gnu.version_d)
    /* Addresses of memory regions reserved via
       SOC_RESERVE_MEMORY_REGION() */
    soc_reserved_memory_region_start = ABSOLUTE(.);
    KEEP (*(.reserved_memory_address))
    soc_reserved_memory_region_end = ABSOLUTE(.);
    _rodata_end = ABSOLUTE(.);
    /* Literals are also RO data. */
    _lit4_start = ABSOLUTE(.);
    *(*.lit4)
    *(.lit4.*)
    *(.gnu.linkonce.lit4.*)
    _lit4_end = ABSOLUTE(.);
    . = ALIGN(4);
    _thread_local_start = ABSOLUTE(.);
    *(.tdata)
    *(.tdata.*)
    *(.tbss)
    *(.tbss.*)
    _thread_local_end = ABSOLUTE(.);
    . = ALIGN(4);
  } >default_rodata_seg

  .flash.text :
  {
    _stext = .;
    _text_start = ABSOLUTE(.);

    *(EXCLUDE_FILE(*libesp_ringbuf.a *libgcov.a *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW.* *libgcc.a:lib2funcs.* *libgcc.a:_divsf3.* *librtc.a *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libesp_system.a:reset_reason.* *libesp_system.a:panic_handler.* *libesp_system.a:panic.* *libesp_common.a:esp_err.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_gd.* *libsoc.a:systimer_hal.* *libsoc.a:rtc_periph.* *libsoc.a:rtc_sleep.* *libsoc.a:spi_hal_iram.* *libsoc.a:cpu_util.* *libsoc.a:i2c_hal_iram.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:uart_hal_iram.* *libsoc.a:soc_hal.* *libsoc.a:cpu_hal.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_time.* *libsoc.a:rtc_clk.* *libsoc.a:ledc_hal_iram.* *libsoc.a:rtc_pm.* *libsoc.a:wdt_hal_iram.* *libsoc.a:lldesc.* *libsoc.a:spi_flash_hal_gpspi.* *libsoc.a:rtc_wdt.* *libxtensa.a:eri.* *libxtensa.a:stdatomic.* *libnewlib.a:heap.* *libnewlib.a:abort.* *libhal.a *libfreertos.a) .literal EXCLUDE_FILE(*libesp_ringbuf.a *libgcov.a *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW.* *liblog.a:log.* *liblog.a:log_freertos.* *libgcc.a:lib2funcs.* *libgcc.a:_divsf3.* *libesp_event.a:default_event_loop.* *libesp_event.a:esp_event.* *librtc.a *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libesp_system.a:system_api.* *libesp_system.a:reset_reason.* *libesp_system.a:panic_handler.* *libesp_system.a:panic.* *libesp_common.a:esp_err.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_gd.* *libsoc.a:rtc_init.* *libsoc.a:systimer_hal.* *libsoc.a:rtc_periph.* *libsoc.a:rtc_sleep.* *libsoc.a:spi_hal_iram.* *libsoc.a:cpu_util.* *libsoc.a:i2c_hal_iram.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:uart_hal_iram.* *libsoc.a:soc_hal.* *libsoc.a:cpu_hal.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_time.* *libsoc.a:rtc_clk.* *libsoc.a:ledc_hal_iram.* *libsoc.a:rtc_pm.* *libsoc.a:wdt_hal_iram.* *libsoc.a:lldesc.* *libsoc.a:spi_flash_hal_gpspi.* *libsoc.a:rtc_wdt.* *libxtensa.a:eri.* *libxtensa.a:stdatomic.* *libnewlib.a:heap.* *libnewlib.a:abort.* *libhal.a *libfreertos.a) .literal.* EXCLUDE_FILE(*libesp_ringbuf.a *libgcov.a *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW.* *libgcc.a:lib2funcs.* *libgcc.a:_divsf3.* *librtc.a *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libesp_system.a:reset_reason.* *libesp_system.a:panic_handler.* *libesp_system.a:panic.* *libesp_common.a:esp_err.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_gd.* *libsoc.a:systimer_hal.* *libsoc.a:rtc_periph.* *libsoc.a:rtc_sleep.* *libsoc.a:spi_hal_iram.* *libsoc.a:cpu_util.* *libsoc.a:i2c_hal_iram.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:uart_hal_iram.* *libsoc.a:soc_hal.* *libsoc.a:cpu_hal.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_time.* *libsoc.a:rtc_clk.* *libsoc.a:ledc_hal_iram.* *libsoc.a:rtc_pm.* *libsoc.a:wdt_hal_iram.* *libsoc.a:lldesc.* *libsoc.a:spi_flash_hal_gpspi.* *libsoc.a:rtc_wdt.* *libxtensa.a:eri.* *libxtensa.a:stdatomic.* *libnewlib.a:heap.* *libnewlib.a:abort.* *libhal.a *libfreertos.a) .text EXCLUDE_FILE(*libesp_ringbuf.a *libgcov.a *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW.* *liblog.a:log.* *liblog.a:log_freertos.* *libgcc.a:lib2funcs.* *libgcc.a:_divsf3.* *libesp_event.a:default_event_loop.* *libesp_event.a:esp_event.* *librtc.a *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libesp_system.a:system_api.* *libesp_system.a:reset_reason.* *libesp_system.a:panic_handler.* *libesp_system.a:panic.* *libesp_common.a:esp_err.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_gd.* *libsoc.a:rtc_init.* *libsoc.a:systimer_hal.* *libsoc.a:rtc_periph.* *libsoc.a:rtc_sleep.* *libsoc.a:spi_hal_iram.* *libsoc.a:cpu_util.* *libsoc.a:i2c_hal_iram.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:uart_hal_iram.* *libsoc.a:soc_hal.* *libsoc.a:cpu_hal.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_time.* *libsoc.a:rtc_clk.* *libsoc.a:ledc_hal_iram.* *libsoc.a:rtc_pm.* *libsoc.a:wdt_hal_iram.* *libsoc.a:lldesc.* *libsoc.a:spi_flash_hal_gpspi.* *libsoc.a:rtc_wdt.* *libxtensa.a:eri.* *libxtensa.a:stdatomic.* *libnewlib.a:heap.* *libnewlib.a:abort.* *libhal.a *libfreertos.a) .text.* EXCLUDE_FILE(*libpp.a *libnet80211.a *libsoc.a:uart_hal_iram.*) .wifi0iram EXCLUDE_FILE(*libpp.a *libnet80211.a *libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .wifi0iram.* EXCLUDE_FILE(*libpp.a *libnet80211.a *libsoc.a:uart_hal_iram.*) .wifirxiram EXCLUDE_FILE(*libpp.a *libnet80211.a *libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .wifirxiram.*)
    *libesp_event.a:default_event_loop.*(.literal.esp_event_handler_register .literal.esp_event_handler_instance_register .literal.esp_event_handler_unregister .literal.esp_event_handler_instance_unregister .literal.esp_event_post .literal.esp_event_loop_create_default .literal.esp_event_loop_delete_default .literal.esp_event_send_to_default_loop .text.esp_event_handler_register .text.esp_event_handler_instance_register .text.esp_event_handler_unregister .text.esp_event_handler_instance_unregister .text.esp_event_post .text.esp_event_loop_create_default .text.esp_event_loop_delete_default .text.esp_event_send_to_default_loop)
    *libesp_event.a:esp_event.*(.literal.handler_instances_remove_all .literal.base_node_remove_all_handler .literal.loop_node_remove_all_handler .literal.handler_instances_add .literal.base_node_add_handler .literal.loop_node_add_handler .literal.handler_instances_remove .literal.base_node_remove_handler .literal.loop_node_remove_handler .literal.esp_event_loop_create .literal.esp_event_loop_run .literal.esp_event_loop_run_task .literal.esp_event_loop_delete .literal.esp_event_handler_register_with_internal .literal.esp_event_handler_register_with .literal.esp_event_handler_instance_register_with .literal.esp_event_handler_unregister_with_internal .literal.esp_event_handler_unregister_with .literal.esp_event_handler_instance_unregister_with .literal.esp_event_post_to .text.handler_execute .text.handler_instances_remove_all .text.base_node_remove_all_handler .text.loop_node_remove_all_handler .text.handler_instances_add .text.base_node_add_handler .text.loop_node_add_handler .text.handler_instances_remove .text.base_node_remove_handler .text.loop_node_remove_handler .text.esp_event_loop_create .text.esp_event_loop_run .text.esp_event_loop_run_task .text.esp_event_loop_delete .text.esp_event_handler_register_with_internal .text.esp_event_handler_register_with .text.esp_event_handler_instance_register_with .text.esp_event_handler_unregister_with_internal .text.esp_event_handler_unregister_with .text.esp_event_handler_instance_unregister_with .text.esp_event_post_to .text.esp_event_dump)
    *libesp_system.a:system_api.*(.literal.esp_register_shutdown_handler .literal.esp_unregister_shutdown_handler .literal.esp_get_free_heap_size .literal.esp_get_free_internal_heap_size .literal.esp_get_minimum_free_heap_size .literal.esp_get_idf_version .text.esp_register_shutdown_handler .text.esp_unregister_shutdown_handler .text.esp_get_free_heap_size .text.esp_get_free_internal_heap_size .text.esp_get_minimum_free_heap_size .text.esp_get_idf_version)
    *libfreertos.a:queue.*( .wifi0iram.*  .wifirxiram.*)
    *libfreertos.a:queue.*(.literal.xQueueGenericCreateStatic .text.xQueueGenericCreateStatic .wifi0iram.xQueueGenericCreateStatic .wifirxiram.xQueueGenericCreateStatic)
    *liblog.a:log.*(.literal.heap_bubble_down .literal.esp_log_set_vprintf .literal.esp_log_level_set .literal.esp_log_writev .text.heap_bubble_down .text.esp_log_set_vprintf .text.esp_log_level_set .text.esp_log_writev)
    *liblog.a:log_freertos.*(.literal.esp_log_system_timestamp .text.esp_log_system_timestamp)
    *libsoc.a:rtc_init.*(.literal.rtc_init .literal.rtc_vddsdio_get_config .text.rtc_init .text.rtc_vddsdio_get_config)
    *libsoc.a:uart_hal_iram.*( .literal  .literal.*  .text  .text.*  .wifi0iram  .wifi0iram.*  .wifirxiram  .wifirxiram.*)

    *(.stub .gnu.warning .gnu.linkonce.literal.* .gnu.linkonce.t.*.literal .gnu.linkonce.t.*)
    *(.irom0.text) /* catch stray ICACHE_RODATA_ATTR */
    *(.fini.literal)
    *(.fini)
    *(.gnu.version)
    _text_end = ABSOLUTE(.);
    _etext = .;

    /* Similar to _iram_start, this symbol goes here so it is
       resolved by addr2line in preference to the first symbol in
       the flash.text segment.
    */
    _flash_cache_start = ABSOLUTE(0);
  } >default_code_seg

  /* Marks the end of IRAM code segment */
  .iram0.text_end (NOLOAD) :
  {
    . = ALIGN (4);
    _iram_text_end = ABSOLUTE(.);
  } > iram0_0_seg

  .iram0.data :
  {
    . = ALIGN(4);
    _iram_data_start = ABSOLUTE(.);

    /* coredump mapping */
    _coredump_iram_start = ABSOLUTE(.);
    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .iram.data.coredump EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .iram.data.coredump.*)
    *libfreertos.a:queue.*( .iram.data.coredump.*)
    *libfreertos.a:queue.*(.iram.data.coredump.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .iram.data.coredump  .iram.data.coredump.*)
    _coredump_iram_end = ABSOLUTE(.);
    
    /* should be placed after coredump mapping */
    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .iram.data EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .iram.data.*)
    *libfreertos.a:queue.*( .iram.data.*)
    *libfreertos.a:queue.*(.iram.data.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .iram.data  .iram.data.*)

    _iram_data_end = ABSOLUTE(.);
  } > iram0_0_seg

  .iram0.bss (NOLOAD) :
  {
    . = ALIGN(4);
    _iram_bss_start = ABSOLUTE(.);

    *(EXCLUDE_FILE(*libsoc.a:uart_hal_iram.*) .iram.bss EXCLUDE_FILE(*libsoc.a:uart_hal_iram.* *libfreertos.a:queue.*) .iram.bss.*)
    *libfreertos.a:queue.*( .iram.bss.*)
    *libfreertos.a:queue.*(.iram.bss.xQueueGenericCreateStatic)
    *libsoc.a:uart_hal_iram.*( .iram.bss  .iram.bss.*)

    _iram_bss_end = ABSOLUTE(.);
    . = ALIGN(4);
    _iram_end = ABSOLUTE(.);
   } > iram0_0_seg

  /* Marks the end of data, bss and possibly rodata  */
  .dram0.heap_start (NOLOAD) :
  {
    . = ALIGN (8);
    _heap_start = ABSOLUTE(.);
  } > dram0_0_seg
}

ASSERT(((_iram_end - ORIGIN(iram0_0_seg)) <= LENGTH(iram0_0_seg)),
          "IRAM0 segment data does not fit.")

ASSERT(((_heap_start - ORIGIN(dram0_0_seg)) <= LENGTH(dram0_0_seg)),
          "DRAM segment data does not fit.")
