module lab7_tb();

logic clk, reset, write;
logic [3:0]num1;
logic [2:0]sel1;
logic segA1;
logic segB1;
logic segC1;
logic segD1;
logic segE1;
logic segF1;
logic segG1;
logic an00;
logic an11;
logic an22;
logic an33;
logic an44;
logic an55;
logic an66;
logic an77;
logic clk1;

lab7 MHH(
    .num(num1),
    .sel(sel1),
    .clk(clk),
    .clk1(clk1),
    .reset(reset),
    .write(write),
    .segA(segA1),
    .segB(segB1),
    .segC(segC1),
    .segD(segD1),
    .segE(segE1),
    .segF(segF1),
    .segG(segG1),
    .an0(an00),
    .an1(an11),
    .an2(an22),
    .an3(an33),
    .an4(an44),
    .an5(an55),
    .an6(an66),
    .an7(an77)
);

initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    reset <= 1;
    write <= 1;
    num1 <= 4'b0000;
    sel1 <= 3'b000;

    @(posedge clk); reset <= 0;
    @(posedge clk1); sel1 <= #1 3'b001; num1 <= #1 4'b1001;
    @(posedge clk1); sel1 <= #1 3'b010; num1 <= #1 4'b1010;
    @(posedge clk1); sel1 <= #1 3'b011; num1 <= #1 4'b1011;
    @(posedge clk1); sel1 <= #1 3'b100; num1 <= #1 4'b1100;
    @(posedge clk1); sel1 <= #1 3'b101; num1 <= #1 4'b1101;
    @(posedge clk1); sel1 <= #1 3'b110; num1 <= #1 4'b1110;
    @(posedge clk1); sel1 <= #1 3'b111; num1 <= #1 4'b1111;
    @(posedge clk1); write <= #1 0;
    @(posedge clk1);
    $stop;
end
endmodule