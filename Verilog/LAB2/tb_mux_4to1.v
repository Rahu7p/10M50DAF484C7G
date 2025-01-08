//Timescale in nanoseconds with a picoseconds precision
`timescale 1ns / 1ps

//Entity: no inputs and outputs list!
module tb_mux_4to1;

    // Internal Wires
    reg x0_tb, x1_tb, x2_tb, x3_tb;//   Inputs
    reg [1:0] sel_tb;//                 Input
    wire y_tb;//                        Output

    // Expected output for validation
    reg expect;

    // Instantiate the Design Under Test (DUT)
    mux_4to1 DUT (
        .x0(x0_tb),
        .x1(x1_tb),
        .x2(x2_tb),
        .x3(x3_tb),
        .sel(sel_tb),
        .y(y_tb)
    );

    // Stimulus process
    initial begin
        // Test case 1
        x0_tb = 0; x1_tb = 1; x2_tb = 0; x3_tb = 1; sel_tb = 2'b00; expect = 0;
        #10;        
        // Test case 2
        x0_tb = 0; x1_tb = 1; x2_tb = 0; x3_tb = 1; sel_tb = 2'b01; expect = 1;
        #10;        
        // Test case 3
        x0_tb = 0; x1_tb = 1; x2_tb = 0; x3_tb = 1; sel_tb = 2'b10; expect = 0;
        #10;        
        // Test case 4
        x0_tb = 0; x1_tb = 1; x2_tb = 0; x3_tb = 1; sel_tb = 2'b11; expect = 1;
        #10;
        // Finish simulation
        $finish;
    end
endmodule
