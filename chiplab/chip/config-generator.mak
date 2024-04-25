CHIPLAB_HOME=/home/mulin/chiplab
CURRENT_DESIGN_TOP=soc_demo
SOC_TOP_NAME=soc_top
TOP_SOC_SRC=${CHIPLAB_HOME}/chip/${CURRENT_DESIGN_TOP}/sim
MYCPU=y
BRIDGE=n
CONFREG=y
AXI_RAND=y
AXI_SRAM=y
AXI64=n
AXI128=n
CPU_2CMT=n
MYCPU_SRC=${CHIPLAB_HOME}/IP/myCPU
BRIDGE_SRC=${CHIPLAB_HOME}/IP/BRIDGE
CONFREG_SRC=${CHIPLAB_HOME}/IP/CONFREG
AXI_RAND_SRC=${CHIPLAB_HOME}/IP/AXI_DELAY_RAND
AXI_SRAM_SRC=${CHIPLAB_HOME}/IP/AXI_SRAM_BRIDGE
AMBA_SRC=${CHIPLAB_HOME}/IP/AMBA
APB_DEV_SRC=${CHIPLAB_HOME}/IP/APB_DEV
UART_SRC=${CHIPLAB_HOME}/IP/APB_DEV/URT
NAND_SRC=${CHIPLAB_HOME}/IP/APB_DEV/NAND
