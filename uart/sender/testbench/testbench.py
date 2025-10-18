import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
from cocotbext.axi import AxiStreamBus, AxiStreamSource, AxiStreamFrame

@cocotb.test()
async def uart_test(dut):
    # start clock
    cocotb.start_soon(Clock(dut.clk, 83.33, units="ns").start())

    # reset
    dut.rst.value = 1
    await Timer(100, units="ns")
    dut.rst.value = 0
    await RisingEdge(dut.clk)

    # créer le bus AXI Stream
    axis_source = AxiStreamSource(AxiStreamBus.from_prefix(dut, "s_axi_s"), dut.clk, dut.rst)

    # envoyer un octet
    frame = AxiStreamFrame([0x41])  # caractère 'A'
    await axis_source.send(frame)

    # attendre que la trame complète soit envoyée
    BAUD_DIV = 104
    total_cycles = BAUD_DIV * 10  # 1 start + 8 data + 1 stop
    tx_bits = []
    for _ in range(total_cycles):
        await RisingEdge(dut.clk)
        tx_bits.append(int(dut.tx.value))

    # reconstruire le caractère reçu
    # échantillonnage au milieu de chaque bit
    sampled_bits = []
    for i in range(10):
        sampled_bits.append(tx_bits[i*BAUD_DIV + BAUD_DIV//2])
    
    start_bit = sampled_bits[0]
    data_bits = sampled_bits[1:9]
    stop_bit = sampled_bits[9]

    print(f"Start={start_bit}, Data={data_bits}, Stop={stop_bit}")
    data_value = 0
    for i, b in enumerate(data_bits):
        data_value |= (b << i)
    print(f"Valeur reçue sur tx: 0x{data_value:02X} ({chr(data_value)})")

    assert start_bit == 0, "Start bit incorrect"
    assert stop_bit == 1, "Stop bit incorrect"
    assert data_value == 0x41, "Données incorrectes"