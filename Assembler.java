import java.io.*;
import java.lang.Integer;

public class Assembler {

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

    public static String toReg2(String s) {
        String reg = s.substring(1);
        int regNum = Integer.parseInt(reg);
        String result = Integer.toBinaryString(regNum);
        if(result.length() == 1) result = "0" + result;
        return result;
    }
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
    //4 bits
    public static String toReg(String s) {
        String reg = s.substring(1);
        String result = toBinary(reg);
        return result;
    }

    public static String parseCommand(String s) {
        String[] inst = s.split(" ");
        String result = "";

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

    public static void main(String args[]) throws IOException{
        File file = new File(args[0]);
        BufferedReader reader;
        PrintWriter writer = new PrintWriter(args[1]);
        String line = "";

        reader = new BufferedReader(new FileReader(file));
        String text;

        while((text = reader.readLine()) != null) {
            line = parseCommand(text);
            //System.out.println(text + " : " + line);
            writer.println(line);
        }
        writer.close();

    }

}
