# https://www.cs.rochester.edu/~brown/173/readings/05_grammars.txt
# "TINY" Grammar
#
# PGM        -->   STMT+
# STMT       -->   ASSIGN   |   "print"  EXP                           
# ASSIGN     -->   ID  "="  EXP
# EXP        -->   TERM   ETAIL
# ETAIL      -->   "+" TERM   ETAIL  | "-" TERM   ETAIL | EPSILON
# TERM       -->   FACTOR  TTAIL
# TTAIL      -->   "*" FACTOR TTAIL  | "/" FACTOR TTAIL | EPSILON
# FACTOR     -->   "(" EXP ")" | INT | ID   
#                  
# ID         -->   ALPHA+
# ALPHA      -->   a  |  b  | … | z  or 
#                  A  |  B  | … | Z
# INT        -->   DIGIT+
# DIGIT      -->   0  |  1  | …  |  9
# WHITESPACE -->   Ruby Whitespace

#
#  Class Scanner - Reads a TINY program and emits tokens
#
class Scanner 
# Constructor - Is passed a file to scan and outputs a token
#               each time nextToken() is invoked.
#   @c        - A one character lookahead 
	def initialize(filename)
		# Need to modify this code so that the program
		# doesn't abend if it can't open the file but rather
		# displays an informative message
        if (!File.file?(filename))
            puts "Error, file does not exist"
            exit
        end
		@f = File.open(filename,'r:utf-8')
		
		# Go ahead and read in the first character in the source
		# code file (if there is one) so that you can begin
		# lexing the source code file 
		if (! @f.eof?)
			@c = @f.getc()
		else
			@c = "eof"
			@f.close()
		end
	end
	
	# Method nextCh() returns the next character in the file
	def nextCh()
		if (! @f.eof?)
			@c = @f.getc()
		else
			@c = "eof"
		end
		
		return @c
	end

	# Method nextToken() reads characters in the file and returns
	# the next token
	# You should also print what you find. Follow the format from the
	# example given in the instructions.
	def nextToken() 
		if @c == "eof"
			return Token.new(Token::EOF,"eof")
				

		elsif (whitespace?(@c))
			str =""
			
			while whitespace?(@c)
				str += @c
				nextCh()
			end
			tok = Token.new(Token::WS,str)
			return tok
           

		elsif (numeric?(@c)) 
			num = ""
			
			while numeric?(@c)
				num += @c
				nextCh()
			end
		
			tok = Token.new(Token::INT, num)
			return tok
            
		
        elsif (letter?(@c))
			letters = ""
			
			while letter?(@c)
				letters += @c
				nextCh()
			end
			
            if (letters == "print")
                tok = Token.new(Token::PRINT, letters)
            

            elsif (letters == "epsilon")
                tok = Token.new(Token::EPSILON, letters)
            
            else
			    tok = Token.new(Token::ID, letters)
            end
			return tok
        
            
		elsif (@c == "=")
            eq = ""
              tok = Token.new(Token::ASSIGN, "=")
				nextCh()
            return tok   
            

		elsif (@c == "+") 
			tok = Token.new(Token::ADDOP, "+")
			nextCh()
            return tok
                
		elsif (@c == "-")
			tok = Token.new(Token::SUBOP, "-")
				nextCh()
			return tok
            
    
		elsif (@c == "*")
			tok = Token.new(Token::MULTOP, "*")
      		nextCh()
			return tok
            

		elsif (@c == "/")
			tok = Token.new(Token::DIVOP, "/")
			nextCh()
			return tok
            

		elsif (@c == ")")
			tok = Token.new(Token::RPAREN, ")")
			nextCh()
			return tok
            

		elsif (@c == "(")
			tok = Token.new(Token::LPAREN, "(")
			nextCh()
			return tok
            

		else 
		    tok = Token.new("unknown","unknown")
			nextCh()
            return tok
		    end
	
end
#
# Helper methods for Scanner
#
def letter?(lookAhead)
	lookAhead =~ /^[a-z]|[A-Z]$/
end

def numeric?(lookAhead)
	lookAhead =~ /^(\d)+$/
end

def whitespace?(lookAhead)
	lookAhead =~ /^(\s)+$/
end
end