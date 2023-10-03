vlib work

vlog adder.v ALU.v alu_Control.v control_unit.v CPU_wrapper.sv CU_wrapper.sv data_mem.v data_path.sv  Imm_gen.v Inst_mem.v MUX_2X1.v MUX_3X1.v pc.v Reg_file.v RISC_V.sv TB.sv +cover

vsim -voptargs=+acc work.TB -cover

add wave *

run -all

coverage save TB.ucdb -onexit 

quit -sim

vcover report TB.ucdb -all -annotate -details  -output coverage.txt
