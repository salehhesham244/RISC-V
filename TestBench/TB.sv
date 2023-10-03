module TB ();
     
    parameter WIDTH =32;

   /*Declaration of used signals*/
   bit clk,rst_n;
   int correct_count,error_count;

   /*Instantiation*/
   RISC_V DUT (clk,rst_n);

   initial begin
    clk=0;
    forever begin
        #1 clk=~clk;
    end
   end 
   
   initial begin
        error_count=0;
        correct_count=0;
        
        check_rst();
        print_info();
        
        check_regfile (2,5);
        print_info();
        
        check_regfile (3,32'hc);
        print_info();
        
        check_regfile (7,3);
        print_info();

        check_regfile (4,7);
        print_info();

    	check_regfile (5,4);
    	print_info();

        check_regfile (5,11);
        print_info();

    	check_PC ('h1C);
        print_info();

    	check_regfile (4,0);
        print_info();

    	check_PC ('h28);
        print_info();

    	check_regfile (4,1);
    	print_info();

        check_regfile (7,12);
    	print_info();

        check_regfile (7,7);
        print_info();

    	check_DMEM (96,7);
        print_info();

        check_regfile (2,7);
        print_info();

        check_regfile (9,18);
        print_info();

    	check_PC ('h48);
        print_info();

        check_regfile (2,25);
        print_info();

        check_DMEM (100,25);
        print_info();
    	
    	check_regfile (20 ,32'h12345000);
        print_info();

        check_regfile (23,32'h2C_0000);
        print_info();

        check_regfile (6,32'h0000_0000);
        print_info();

        check_PC ('h68);
        print_info();

        check_JALR (21, 32'h0000006C, 32'h00000008);
        print_info();
        
        $display("the correct_count=%0d",correct_count);
        $display("the error_count=%0d",error_count);

    #2 $stop;
   end

                            /***************Tasks****************/
task check_rst ();
    rst_n=0;
    @(negedge clk);
    rst_n=1;
endtask //

task check_PC (bit [WIDTH-1:0] expected_pc);
    @(negedge clk);
    if (expected_pc != DUT.cpu_DUT.Dpath_DUT.pc_dut.out) begin
        error_count++;
        $display("%t:ERROR In the taken PC",$time);
       $stop;
    end
    else begin
        correct_count++;
    end
endtask //check_pc

task  check_DMEM (bit [7:0] addr,bit [WIDTH-1] exp_value);
        @(negedge clk);
    if (exp_value != DUT.Dmem_DUT.ram[addr]) begin
        error_count++;
        $display("%t:ERROR In the Value of the data_memory and the value=%0d",$time,DUT.Dmem_DUT.ram[addr]);
        $stop;        
    end
    else begin
         correct_count++;
    end
    
endtask //Data_mem

task check_regfile(bit [4:0] index,bit [WIDTH-1:0] exp_value);
       @(negedge clk);
        if (exp_value != DUT.cpu_DUT.Dpath_DUT.RegFile_dut.regfile[index]) begin
        error_count++;
        $display("%t:ERROR In the Value stored in the register file",$time);
        $stop;        
    end
    else begin
         correct_count++;
    end
endtask //check_regFile

task  check_JALR (bit [4:0] index,bit [WIDTH-1:0] exp_value, bit [WIDTH-1:0] exp_pc);
           @(negedge clk);
        if (exp_value != DUT.cpu_DUT.Dpath_DUT.RegFile_dut.regfile[index]) begin
        error_count++;
        $display("%t:ERROR In the Value stored in the register file",$time);
        $stop;        
    end
    else begin
         correct_count++;
    end
        if (exp_pc != DUT.cpu_DUT.Dpath_DUT.pc_dut.out) begin
        error_count++;
        $display("%t:ERROR In the taken  and it's value =%0d",$time,DUT.cpu_DUT.Dpath_DUT.pc_dut.out);
        $stop;        
    end
    else begin
         correct_count++;
    end
endtask //check_jalr

function print_info();
        $display ("the pc value is=%0d",DUT.cpu_DUT.Dpath_DUT.pc_dut.out);
        $display("the input instructiion =%h",DUT.cpu_DUT.Dpath_DUT.inst);
        $display("the output instructiion from imem =%h",DUT.Imem_DUT.instruction);
        $display("the input address to the imem =%h",DUT.Imem_DUT.addr);
        $display("the input address to the Dmem =%h",DUT.cpu_DUT.Dpath_DUT.address);
        $display("the address of the Dmem =%h",DUT.Dmem_DUT.addr);
        $display("the input value to the Dmem =%h",DUT.cpu_DUT.Dpath_DUT.Written_DMem);
        $display("the  value of the Dmem =%h",DUT.Dmem_DUT.din);
        $display ("the value of the alu=%0d",DUT.cpu_DUT.Dpath_DUT.alu_dut.C);
        $display ("the value input to the register file =%0d",DUT.cpu_DUT.Dpath_DUT.RegFile_dut.DataD);
        $display ("the selectors value input to the 3x1 mux =%0d",DUT.cpu_DUT.Dpath_DUT.mux_3x1_dut1.SEL);
        $display ("the immediate value input to the 3x1 mux =%0d",DUT.cpu_DUT.Dpath_DUT.mux_3x1_dut1.C);
        $display ("the value output of the 3x1 mux =%0d",DUT.cpu_DUT.Dpath_DUT.mux_3x1_dut1.out);
        $display ("the pc input value =%0d",DUT.cpu_DUT.Dpath_DUT.pc_dut.D);
        $display ("the pc output value =%0d",DUT.cpu_DUT.Dpath_DUT.pc_dut.out);
endfunction

endmodule