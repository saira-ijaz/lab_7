module clk_delay_tb;
logic clk1;
logic clk_out1;
logic reset;

clk_delay MMH(
    .clk(clk1),
    .reset(reset),
    .clk_out(clk_out1)
);

initial begin
    clk1 = 1'b0;
    forever #5 clk1 = ~clk1;
end

initial begin
    reset <= #1 1;
    @(posedge clk1); reset <= #1 0;
end
endmodule