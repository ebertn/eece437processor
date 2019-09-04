//`include "cpu_types_pkg.vh"

module alu (
  alu_if.alu aluif  
);

//import cpu_types_pkg::*;

// alu op width
parameter AOP_W     = 4;

// alu op type
typedef enum logic [AOP_W-1:0] {
	ALU_SLL     = 4'b0000,        
	ALU_SRL     = 4'b0001,        
	ALU_ADD     = 4'b0010,        
	ALU_SUB     = 4'b0011,        
	ALU_AND     = 4'b0100,        
	ALU_OR      = 4'b0101,        
	ALU_XOR     = 4'b0110,        
	ALU_NOR     = 4'b0111,        
	ALU_SLT     = 4'b1010,        
	ALU_SLTU    = 4'b1011         
} aluop_t; 

always_comb begin
	aluif.zero = aluif.outPort == '0;
	aluif.negative = aluif.outPort[31];
end

always_comb begin
    aluif.outPort = '0;
    aluif.overflow = 0;

    case (aluif.aluOp)
        ALU_SLL: begin
            aluif.outPort = aluif.portA << aluif.portB; 
        end

        ALU_SRL: begin
            aluif.outPort = aluif.portA >> aluif.portB; 
        end

        ALU_AND: begin
            aluif.outPort = aluif.portA & aluif.portB; 
        end

        ALU_OR: begin
            aluif.outPort = aluif.portA | aluif.portB; 
        end
        
        ALU_XOR: begin
            aluif.outPort = aluif.portA ^ aluif.portB; 
        end

        ALU_NOR: begin
            aluif.outPort = ~(aluif.portA | aluif.portB); 
        end

        ALU_ADD: begin
            aluif.outPort = aluif.portA + aluif.portB; 
            aluif.overflow = (aluif.portA[31] && aluif.portB[31] && !aluif.outPort[31]) 
			|| (!aluif.portA[31] && !aluif.portB[31] && aluif.outPort[31]);
        end

        ALU_SUB: begin
            aluif.outPort = aluif.portA - aluif.portB; 
            aluif.overflow = (aluif.portA[31] && !aluif.portB[31] && !aluif.outPort[31]) 
			|| (!aluif.portA[31] && aluif.portB[31] && aluif.outPort[31]);
        end   

        ALU_SLT: begin
            //aluif.outPort = aluif.portA[30:0] < aluif.portB[30:0] && aluif.portA[31] <= aluif.portB[31]; 

            aluif.outPort = aluif.portA - aluif.portB; 
        end

        ALU_SLTU: begin
            aluif.outPort = {1'b0, aluif.portA} - {1'b0, aluif.portB}; 
        end
    endcase
end
endmodule
