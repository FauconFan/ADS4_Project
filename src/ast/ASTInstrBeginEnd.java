package src.ast;

import src.lexer_parser.Sym;

public class ASTInstrBeginEnd extends ASTInstr
{
	private AST content;

	public ASTInstrBeginEnd(AST content)
	{
		this.content = content;
	}

	public String toString()
	{
		String in;
		boolean hasLastNL = false;

		in = content.toString();
		hasLastNL = (in.charAt(in.length() - 1) == '\n');
		if (hasLastNL)
		{
			in = in.substring(0, in.length() - 1);
		}
		in = in.replace("\n", "\n\t");
		if (hasLastNL)
		{
			in += "\n";
		}
		return ("Begin ASTInstrBeginEnd" + "\n\t" + in + "End ASTInstrBeginEnd");
	}
}