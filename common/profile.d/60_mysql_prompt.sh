# Test Colors:
# echo -e "\x1B[38;5;3m\x1B[48;5;52m SQL \x1B[38;5;52m\x1B[48;5;88m\x1B[38;5;3m\x1B[48;5;88m root@localhost \x1B[38;5;88m\x1B[48;5;124m\x1B[38;5;3m\x1B[48;5;124m 3306 \x1B[38;5;124m\x1B[48;5;196m\x1B[38;5;3m\x1B[48;5;196m information_schema \x1B[38;5;196m\x1B[48;5;226m\x1B[38;5;52m\x1B[48;5;226m ? \x1B[0m\x1B[38;5;226m\x1B[0m"

#export MYSQL_PS2=$(echo -e "\x1B[38;5;3m\x1B[48;5;52m SQL \x1B[38;5;52m\x1B[48;5;88m\x1B[38;5;3m\x1B[48;5;88m \\U \x1B[38;5;88m\x1B[48;5;124m\x1B[38;5;3m\x1B[48;5;124m \\p \x1B[38;5;124m\x1B[48;5;196m\x1B[38;5;3m\x1B[48;5;196m \\d \x1B[38;5;196m\x1B[48;5;226m\x1B[38;5;52m\x1B[48;5;226m ? \x1B[0m\x1B[38;5;226m\x1B[0m")

#export MYSQL_PS1=$(echo -e "\001\x1B[38;5;52m\002\001\x1B[48;5;226m\002 SQL  \\U  \\p  \\d  ? \001\x1B[0m\002\001\x1B[38;5;226m\002\001\x1B[0m\002 ")

#export MYSQL_PS1=$(echo -e "\001\x1B[31m\002 SQL  \\U  \\p  \\d  ? \001\x1B[0m\002 ")

export MYSQL_PS1=$(echo -e "\001\x1B[38;5;3m\002\001\x1B[48;5;52m\002 SQL \001\x1B[38;5;52m\002\001\x1B[48;5;88m\002\001\x1B[38;5;3m\002\001\x1B[48;5;88m\002 \\U \001\x1B[38;5;88m\002\001\x1B[48;5;124m\002\001\x1B[38;5;3m\002\001\x1B[48;5;124m\002 \\p \001\x1B[38;5;124m\002\001\x1B[48;5;196m\002\001\x1B[38;5;3m\002\001\x1B[48;5;196m\002 \\d \001\x1B[38;5;196m\002\001\x1B[48;5;226m\002\001\x1B[38;5;52m\002\001\x1B[48;5;226m\002 ? \001\x1B[0m\002\001\x1B[38;5;226m\002\001\x1B[0m\002 ")