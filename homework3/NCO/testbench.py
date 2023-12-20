import matplotlib.pyplot as plt
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, Timer

@cocotb.test()
async def testbench(dut):
    cocotb.start_soon(Clock(dut.clk, 1, units="ns").start())
    dut.step.value = 170;
    dut.rst.value = 1
    await Timer(100, units = 'ns')
    dut.rst.value = 0
    sin = [0] * 10000;
    sinabs = [0] * 10000;
    for i in range(10000):
        await FallingEdge(dut.clk)
        if (('x' not in dut.out.value.binstr) and ('z' not in dut.out.value.binstr)):
            sin[i] = dut.out.value.signed_integer
            sinabs[i] = abs(sin[i])
    for i in range(10000):
        sin[i] = sin[i] #/ max(sinabs)
    plt.plot(sin)
    plt.savefig(f'1.png')
    plt.show()
    plt.psd(sin, 10000, 10000)
    plt.savefig(f'2.png')
    plt.show();
    n_sin = ["{}\n".format(i) for i in sin]
    with open(r'file.txt', 'w') as fp:
        fp.writelines(n_sin)