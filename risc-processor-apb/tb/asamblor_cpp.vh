
#include <iostream>
#include <string>
#include <stdint.h>

using namespace std;

int main()
{
    string opcode_citit;
    uint32_t instructiune_asamblata;
    
    uint32_t opcode;
    uint32_t dest;
    uint32_t op0;
    uint32_t op1;
    uint32_t value;
    
    int contor_instructiuni = 0;
    
    
    do
    {
        cin >> opcode_citit;
        instructiune_asamblata = 0;  
        
        if(opcode_citit == "NOP")
        {
            opcode = 0;
            dest = 0;
            op0 = 0;
            op1 = 0;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }
        else if(opcode_citit == "ADD")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> a >> op0;
            getchar();
            cin >> a >> op1;
            getchar();
            
            opcode = 1;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        } else if(opcode_citit == "SUB")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> a >> op0;
            getchar();
            cin >> a >> op1;
            getchar();
            
            opcode = 2;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "MULT")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> a >> op0;
            getchar();
            cin >> a >> op1;
            getchar();
            
            opcode = 3;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "SHR")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> a >> op0;
            getchar();
            
            opcode = 4;
            op1 = 0;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "AND")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> a >> op0;
            getchar();
            cin >> a >> op1;
            getchar();
            
            opcode = 6;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "OR")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> a >> op0;
            getchar();
            cin >> a >> op1;
            getchar();
            
            opcode = 7;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "XOR")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> a >> op0;
            getchar();
            cin >> a >> op1;
            getchar();
            
            opcode = 8;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "VL")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> value;
            getchar();
            
            opcode = 10;
            op0 = 0;
            op1 = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "JMP")
        {
            char a;
            
            cin >> a >> value;
            getchar();
            
            opcode = 11;
            dest = 0;
            op0 = 0;
            op1 = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "JMPZ")
        {
            char a;
            
            cin >> a >> value;
            getchar();
            
            opcode = 12;
            dest = 0;
            op0 = 0;
            op1 = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "STORE")
        {
            char a;
            
            cin >> a >> op0;
            getchar();
            cin >> a >> op1;
            getchar();
            
            opcode = 13;
            dest = 0;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }else if(opcode_citit == "LOAD")
        {
            char a;
            
            cin >> a >> dest;
            getchar();
            cin >> a >> op0;
            getchar();
            
            opcode = 14;
            op1 = 0;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }
        else if( opcode_citit == "HALT" )
        {
            opcode = 15;
            dest = 0;
            op0 = 0;
            op1 = 0;
            value = 0;
            instructiune_asamblata = 
                                    ( ( opcode & 15 ) << 28 ) |
                                    ( ( dest & 15 ) << 24 ) |
                                    ( ( op0 & 15 ) << 20 ) |
                                    ( ( op1 & 15 ) << 16 ) |
                                    ( ( value & 65535 ) << 0 );
        }
        else
        {
            cout << "!!!!!!!!!!!!!!!!!!ERROR : invalid instruction detected!!!!!!!!!!!!!!!!!!!!";
            return 1;
        }
        
        
        cout << "dut.instr_mem0.mem_instr[" << contor_instructiuni <<"] = 32'b";
        
        for(int  i = 31 ; i >= 0; i--)
        {
            cout << ((instructiune_asamblata & ( 1 << i))   >>  i   );
            
            if(  (i % 4 == 0) && (i != 0)  )
            {
                cout << "_";
            }
            
        }
        cout << ";";
        cout << endl;
        contor_instructiuni ++; 
        
    }while( opcode_citit != "HALT" );
    

    return 0;
}














