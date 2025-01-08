module mux_4to1 (
    input wire x0, 
    input wire x1, 
    input wire x2, 
    input wire x3,
    input wire [1:0] sel,
    output wire y
);
    assign y = (sel == 2'b11) ? x3 :
               (sel == 2'b10) ? x2 :
               (sel == 2'b01) ? x1 :
                                x0;
endmodule
