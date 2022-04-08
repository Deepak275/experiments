from pssh.clients import ParallelSSHClient
from pssh.utils import enable_host_logger
import sys

enable_host_logger()
# from pssh.clients.miko import ParallelSSHClient


hosts = ['10.27.236.143', '10.27.236.143']
# hosts = ['10.27.236.143', 'localhost', 'localhost', 'localhost']


cmd_list = ['uname', 'echo "deepak"']



for cmd in cmd_list:
  client = ParallelSSHClient(hosts, pkey="~/.ssh/id_rsa")
  output = client.run_command(cmd, stop_on_errors=True)

  client.join(consume_output=True)
  print('coming')
  
  for host_out in output:
    # print("Host %s exit code: %s, except: %s" % (host_out.host, host_out.exit_code, host_out.exception))
    if host_out.exit_code != 0:
      print(host_out.exit_code)
      print("Host %s exit code: %s" % (host_out.host, host_out.exit_code, host_out.exception))
      sys.exit()
