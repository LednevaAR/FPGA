import matplotlib.pyplot as plt
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, Timer

@cocotb.test()
async def testbench(dut):
    cocotb.start_soon(Clock(dut.clk, 1, units="ns").start())
    dut.step.value = 30;
    dut.rst.value = 1
    await Timer(100, units = 'ns')
    dut.rst.value = 0
    sin = [0] * 1000;
    for i in range(1000):
        await FallingEdge(dut.clk)
        if (('x' not in dut.out.value.binstr) and ('z' not in dut.out.value.binstr)):
            sin[i] = dut.out.value.signed_integer
    #plt.plot(sin)
    #plt.savefig(f'1.png')
    plt.psd(sin, 1000, 1000);
    plt.show();