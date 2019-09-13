// control unit interface
`include "control_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module control_unit (
  control_unit_if.cu cuif
);
	// import types
	import cpu_types_pkg::*;

	//modport cu (
	//input   iHit, Equal, dHit, InstrOp, InstrFunc,
	//output  PcSrc, iMemRe, RegDst, AluOp, dMemWr, MemToReg, Halt, dMemRe, AluSrc, ExtOp, regWEN, UpperImm, RegZero, JType, JReg
	//);

	always_comb begin

		cuif.PcSrc = 0;
		cuif.iMemRe = 1;
		cuif.AluOp = ALU_SLL;
		cuif.dMemWr = 0;
		cuif.MemToReg = 0;
		cuif.Halt = 0;
		cuif.dMemRe = 0;
		cuif.AluSrc = 0;
		cuif.ExtOp = 1; // Default is sign ext
		cuif.regWEN = 0;
		cuif.UpperImm = 0;
		cuif.RegZero = 0;
		cuif.JType = 0;
		cuif.JReg = 0;

		if (cuif.InstrOp != RTYPE) begin
			cuif.RegDst = 0; // Rt

			case(cuif.InstrOp)
			    // jtype
				J: begin
					cuif.JType = 1;
					cuif.PcSrc = 1;
					{cuif.JReg,cuif.PcSrc} = 2'b11;
				end

				JAL: begin
					cuif.JType = 1;
					cuif.PcSrc = 1;
					cuif.regWEN = 1;
					{cuif.JReg,cuif.PcSrc} = 2'b11;
				end

				// itype
				BEQ: begin
					cuif.PcSrc = cuif.Equal;
					cuif.AluOp = ALU_SUB;
				end

				BNE: begin
					cuif.PcSrc = !cuif.Equal;
					cuif.AluOp = ALU_SUB;
				end

				ADDI: begin
					cuif.AluOp = ALU_ADD;
					cuif.AluSrc = 1;
					cuif.regWEN = 1;
				end

				ADDIU: begin
					cuif.AluOp = ALU_ADD;
					cuif.AluSrc = 1;
					cuif.regWEN = 1;
				end

				SLTI: begin
					cuif.AluOp = ALU_SLT;
					cuif.AluSrc = 1;
					cuif.regWEN = 1;
				end

				SLTIU: begin
					cuif.AluOp = ALU_SLTU;
					cuif.AluSrc = 1;
					cuif.regWEN = 1;
				end

				ANDI: begin
					cuif.AluOp = ALU_AND;
					cuif.AluSrc = 1;
					cuif.ExtOp = 0;
					cuif.regWEN = 1;
				end

				ORI: begin
					cuif.AluOp = ALU_OR;
					cuif.AluSrc = 1;
					cuif.ExtOp = 0;
					cuif.regWEN = 1;
				end

				XORI: begin
					cuif.AluOp = ALU_XOR;
					cuif.AluSrc = 1;
					cuif.ExtOp = 0;
					cuif.regWEN = 1;
				end

				LUI: begin
					cuif.AluOp = ALU_OR;
					cuif.AluSrc = 1;
					cuif.UpperImm = 1;
					cuif.RegZero = 1;
					cuif.regWEN = 1;
				end

				LW: begin
					cuif.AluOp = ALU_ADD;
					cuif.AluSrc = 1;
					cuif.regWEN = 1;

					// Memory
					cuif.dMemRe = 1;
					cuif.MemToReg = 1;

				end

				SW: begin
					cuif.AluOp = ALU_ADD;
					cuif.AluSrc = 1;

					// Memory
					cuif.dMemWr = 1;
				end

				HALT: begin
					cuif.Halt = 1;
				end

			endcase
		end else begin
			cuif.RegDst = 1; // Rd
		
			case(cuif.InstrFunc)
				// rtype
			    SLLV: begin
					cuif.AluOp = ALU_SLL;
					cuif.regWEN = 1;
			    end

				SRLV: begin
					cuif.AluOp = ALU_SRL;
					cuif.regWEN = 1;
				end

				JR: begin
					{cuif.JReg,cuif.PcSrc} = 2'b10;
				end

				ADD: begin
					cuif.AluOp = ALU_ADD;
					cuif.regWEN = 1;
				end

				ADDU: begin
					cuif.AluOp = ALU_ADD;
					cuif.regWEN = 1;
				end

				SUB: begin
					cuif.AluOp = ALU_SUB;
					cuif.regWEN = 1;
				end

				SUBU: begin
					cuif.AluOp = ALU_SUB;
					cuif.regWEN = 1;
				end

				AND: begin
					cuif.AluOp = ALU_AND;
					cuif.regWEN = 1;
				end

				OR: begin
					cuif.AluOp = ALU_OR;
					cuif.regWEN = 1;
				end

				XOR: begin
					cuif.AluOp = ALU_XOR;
					cuif.regWEN = 1;
				end

				NOR: begin
					cuif.AluOp = ALU_NOR;
					cuif.regWEN = 1;
				end

				SLT: begin
					cuif.AluOp = ALU_SLT;
					cuif.regWEN = 1;
				end

				SLTU: begin
					cuif.AluOp = ALU_SLTU;
					cuif.regWEN = 1;
				end
			endcase
		end
	end

endmodule
