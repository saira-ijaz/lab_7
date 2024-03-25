module lab7 (input logic [3:0] num, 
        input [2:0] sel,
        input logic write, reset, clk,
        output logic an0, an1, an2, an3, an4, an5, an6, an7,
        output logic segA, segB, segC, segD, segE, segF, segG);

logic en0, en1, en2, en3, en4, en5, en6, en7, count_en;
logic [3:0] q0, q1, q2, q3, q4, q5, q6, q7;
logic A, B, C;
logic [2:0] count_d, count_q;

clk_delay tff (
    .clk(clk),
    .reset(reset),
    .clk_out(clk1)
);

always_comb
begin
    A = sel[2];
    B = sel[1];
    C = sel[0];
end

//COMB FOR DFF SELECTION
assign en0 = write & (!A) & (!B) & (!C);
assign en1 = write & (!A) & (!B) & C;
assign en2 = write & (!A) & B & (!C);
assign en3 = write & (!A) & B & C;
assign en4 = write & A & (!B) & (!C);
assign en5 = write & A & (!B) & C;
assign en6 = write & A & B & (!C);
assign en7 = write & A & B & C;
assign count_en = !write;
//D_FFs
d_ff ff0 (
    .q (q0),
    .clk (clk1),
    .reset (reset),
    .enable (en0),
    .d (num)
);
d_ff ff1 (
    .q (q1),
    .clk (clk1),
    .reset (reset),
    .enable (en1),
    .d (num)
);
d_ff ff2 (
    .q (q2),
    .clk (clk1),
    .reset (reset),
    .enable (en2),
    .d (num)
);
d_ff ff3 (
    .q (q3),
    .clk (clk1),
    .reset (reset),
    .enable (en3),
    .d (num)
);
d_ff ff4 (
    .q (q4),
    .clk (clk1),
    .reset (reset),
    .enable (en4),
    .d (num)
);
d_ff ff5 (
    .q (q5),
    .clk (clk1),
    .reset (reset),
    .enable (en5),
    .d (num)
);
d_ff ff6 (
    .q (q6),
    .clk (clk1),
    .reset (reset),
    .enable (en6),
    .d (num)
);
d_ff ff7 (
    .q (q7),
    .clk (clk1),
    .reset (reset),
    .enable (en7),
    .d (num)
);
//COUNTER
always_comb count_d = count_q + 1;
always_ff@(posedge clk1 or posedge reset)
begin
    if (reset) begin
        count_q <= #1 0;
    end
    else if (count_en) begin
        count_q <= #1 count_d;
    end
end
//MUX TO SELECT INPUT TO MUX1
logic [2:0] c;
always_comb begin
    case (write)
        1'b1:c = sel;
        1'b0:c = count_q;
    endcase
end
//MUX1
logic [3:0] y;
always_comb begin
    case (c)
        3'b000:y = q0;
        3'b001:y = q1;
        3'b010:y = q2;
        3'b011:y = q3;
        3'b100:y = q4;
        3'b101:y = q5;
        3'b110:y = q6;
        3'b111:y = q7;
    endcase
end
//DECODER FOR CATHODE
logic [6:0] sara;
always_comb
begin
    segA = sara[6];
    segB = sara[5];
    segC = sara[4];
    segD = sara[3];
    segE = sara[2];
    segF = sara[1];
    segG = sara[0];
end

always_comb begin
    case (y)
        4'b0000: sara = 7'b0000001;
        4'b0001: sara = 7'b1001111;
        4'b0010: sara = 7'b0010010;
        4'b0011: sara = 7'b0000110;
        4'b0100: sara = 7'b1001100;
        4'b0101: sara = 7'b0100100;
        4'b0110: sara = 7'b0100000;
        4'b0111: sara = 7'b0001111;
        4'b1000: sara = 7'b0000000;
        4'b1001: sara = 7'b0000100;
        4'b1010: sara = 7'b0001000;
        4'b1011: sara = 7'b1100000;
        4'b1100: sara = 7'b0110001;
        4'b1101: sara = 7'b1000010;
        4'b1110: sara = 7'b0110000;
        4'b1111: sara = 7'b0111000;
    endcase
end
//DECODER FOR ANODE
logic [7:0] zulfi;
always_comb
begin
    an0 = zulfi[7];
    an1 = zulfi[6];
    an2 = zulfi[5];
    an3 = zulfi[4];
    an4 = zulfi[3];
    an5 = zulfi[2];
    an6 = zulfi[1];
    an7 = zulfi[0];
end

always_comb begin
    case (c)
        3'b000: zulfi = 8'b01111111;
        3'b001: zulfi = 8'b10111111;
        3'b010: zulfi = 8'b11011111;
        3'b011: zulfi = 8'b11101111;
        3'b100: zulfi = 8'b11110111;
        3'b101: zulfi = 8'b11111011;
        3'b110: zulfi = 8'b11111101;
        3'b111: zulfi = 8'b11111110;
    endcase
end

endmodule