import java.io.*;
import java.lang.Integer;

public class Assembler {

    /* Description: Converts the input number into a 4-bit binary String
     @param: String containing the decimal number
     @return: 4-bit Binary string
    */
    public static String toBinary (String s) {
        int num = Integer.parseInt(s);
        String result = Integer.toBinaryString(num);

        //Add leading zeroes - total of 4 bits
        if(result.length() == 1)
            result = "000" + result;
        else if(result.length() == 2)
            result = "00" + result;
        else if(result.length() == 3)
            result = "0" + result;

        return result;
    }

    /* Description: Converts the input number into a 5-bit binary String
     @param: String containing the decimal number
     @return: 5-bit Binary string
    */
    public static String toBinary5 (String s) {
        int num = Integer.parseInt(s);
        String result = Integer.toBinaryString(num);

        //Add leading zeroes - total of 4 bits
        if(result.length() == 1)
            result = "0000" + result;
        else if(result.length() == 2)
            result = "000" + result;
        else if(result.length() == 3)
            result = "00" + result;
        else if(result.length() == 4)
            result = "0" + result;

        return result;
    }

    //Register parse methods

    /* Description: Converts the input number into a 2-bit binary String
     @param: String containing the register name and number
     @return: 2-bit Binary string representing the register
    */
    public static String toReg2(String s) {
        String reg = s.substring(1);
        int regNum = Integer.parseInt(reg);
        String result = Integer.toBinaryString(regNum);
        if(result.length() == 1) result = "0" + result;
        return result;
    }

    /* Description: Converts the input number into a 3-bit binary String
     @param: String containing the register name and number
     @return: 3-bit Binary string representing the register
    */
    public static String toReg3(String s) {
        String reg = s.substring(1);
        int regNum = Integer.parseInt(reg);
        String result = Integer.toBinaryString(regNum);
        if(result.length() == 1)
            result = "00" + result;
        else if (result.length() == 2)
            result = "0" + result;
        return result;
    }

    /* Description: Converts the input number into a 4-bit binary String
     @param: String containing the register name and number
     @return: 4-bit Binary string representing the register
    */
    public static String toReg(String s) {
        String reg = s.substring(1);
        String result = toBinary(reg);
        return result;
    }

    /* Description: Converts a line of assembly code into machine code
     @param: String containing a single line of assembly code
     @return: Corresponding binary (machine) code
    */
    public static String parseCommand(String s) {
        String[] inst = s.split(" ");
        String result = "";

        //Determine the instruction and construct the machine code
        switch(inst[0]) {
            case "rs":
                result = "0001";    //opcode
                result += toBinary(inst[1]);
                result += inst[2];
                break;

            case "ls":
                result = "0010";    //opcode
                result += toBinary(inst[1]);
                result += inst[2];
                break;
            case "mv":
                result = "0011";    //opcode
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "beq":
                result = "0100";    //opcode
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "bgt":
                result = "0101";    //opcode
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "blt":
                result = "0110";    //opcode
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "lsd":
                result = "0111";    //opcode
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "get":
                result = "1000";    //opcode
                result += toBinary5(inst[1]);
                break;
            case "add":
                result = "1001";
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "seq":
                result = "1010";
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "sqb":
                result = "1011";
                result += toReg3(inst[1]);
                result += toReg2(inst[2]);
                break;
            case "scp":
                result = "1100";
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "rlz":
                result = "1101";
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "sg":
                result = "1110";
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "so":
                result = "1111";
                result += toReg(inst[1]);
                result += inst[2];
                break;
            case "halt":
                result = "000000000";
                break;
        }
        return result;
    }

    //Parse the assembly code from input file and write out machine code to output file
    public static void main(String args[]) throws IOException{
        File file = new File(args[0]);
        BufferedReader reader;
        PrintWriter writer = new PrintWriter(args[1]);
        String binaryCode = "";

        reader = new BufferedReader(new FileReader(file));
        String text;

        //Read each line from input file, generate machine code and write to output file
        while((text = reader.readLine()) != null) {
            binaryCode = parseCommand(text);
            writer.println(binaryCode);
        }
        writer.close();

    }

}
