#!/usr/bin/env python
#
# Script criado para monitorar entradasa DEBUG nos logs das instancias do Motion.
# Este problema ocorria um alto tempo de Sync nas instancias e impactava em todo
# o ambiente Motion.
#
# Autor: Marcelo Varge
#
# Uso: ./check_debug_motion.py [NUM] [NUM] [NUM] ...
#
import sys

WL_HOME = "/opt/oracle/domain/servers/"

instancias = []
alertas    = []
palavra    = "DEBUG"
threshold  = 200

for arg in sys.argv[1:]:
        instancias.append("appmotfrt%s" % arg)
        instancias.append("appmotbck%s" % arg)

for jvm in instancias:
        log_file = WL_HOME + jvm + '/' + "logs/" + jvm + ".out"
        try:
                a = open(log_file, 'r')
        except IOError:
                continue
        conteudo = a.read()
        a.close()
        if palavra in conteudo:
                if conteudo.count(palavra) > threshold:
                        alertas.append("Alerta DEBUG em " + jvm + '.')

if alertas:
        alertas.insert(0, "CRITICAL:")
        print ' '.join(alertas)
        sys.exit(2)
else:
        print "OK"
        sys.exit(0)
