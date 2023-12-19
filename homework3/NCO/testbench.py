import cocotb
from cocotb.triggers import FallingEdge, Timer

async def generate_clock(dut):

    for cycle in range(17):
        dut.clk.value = 0
        await Timer(5, units="ps")
        dut.clk.value = 1
        await Timer(5, units="ps")

@cocotb.test()
async def my_test(dut):
    await cocotb.start(generate_clock(dut))
    await Timer(5, units="ns")
    await FallingEdge(dut.clk)