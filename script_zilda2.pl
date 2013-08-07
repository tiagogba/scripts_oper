#############################################################
# Script criado por: Tiago Albuquerque   		           			#
# Vers 1.1v 													                      #
# Data: 01/08/2013 											                    #
# Contato: talbuquerque@uoldiveo 							              #
#############################################################

my $ITEM = folder;
my $MATCH = false;

#Pega o horario local
($SEC,$MIN,$HR) = localtime();

#Define diretorio
@myDir = <P:/REP/RET/*>;

#Looping with condition
if($HR >= 18 and $HR <= 23){

		foreach $dir (@myDir)
			{
			$dir = $dir."/";
			opendir(DIR,$dir) or die "$!";
			readdir DIR; # reads .
			readdir DIR; # reads .
				
				#Se horario for entre 18:00 e 23:00, ele envia o check verdadeiro
				if (readdir DIR)
							{
								#print "tem arquivos\n";
								$dir =~ s/.*\/(.*)\/$/$1/;
								my $VALUE = "$dir esta pasta contem arquivos nao importados";
								my $STATUS = 2;
								my $SERVICE = "folder_$dir";
								my $MONITOR = "folder_$dir";
								system("\"P:/export/scripts/send-xml.pl\" -i \"$ITEM\" -m \"$MONITOR\" -v \"$VALUE\" -s \"$SERVICE\" -u \"$STATUS\" -a \"$MATCH\"");
							}
							else{
								print "nao tem arquivos\n";
									$dir =~ s/.*\/(.*)\/$/$1/;
									my $VALUE = "$dir vazio";
									my $STATUS = 0;
									my $SERVICE = "folder_$dir";
									my $MONITOR = "folder_$dir";
									system("\"P:/export/scripts/send-xml.pl\" -i \"$ITEM\" -m \"$MONITOR\" -v \"$VALUE\" -s \"$SERVICE\" -u \"$STATUS\" -a \"$MATCH\"");
								}
				}
				
				#Se o horario for entre 00:00 e 17:00 ele envia o check fake
				}elsif($HR >= 0 and $HR <= 17){
				
					    #print "hora do check_fake\n";
						foreach $dir (@myDir)
			            {
						
						$dir = $dir."/";
						opendir(DIR,$dir) or die "$!";
						readdir DIR; # reads .
						readdir DIR; # reads .
						$dir =~ s/.*\/(.*)\/$/$1/;
						my $VALUE = "$dir esta pasta contem arquivos nao importados";
						my $STATUS = 0;
						my $SERVICE = "folder_$dir";
						my $MONITOR = "folder_$dir";
						system("\"P:/export/scripts/send-xml.pl\" -i \"$ITEM\" -m \"$MONITOR\" -v \"$VALUE\" -s \"$SERVICE\" -u \"$STATUS\" -a \"$MATCH\"");
						}
				}
