def substring_match(str, substr)
  match_index = []
  flag = 0
  str_chars = str.split('')

  # for value in str_chars do
  #   if value == substr[0] && flag == 0

  #   end  


  
  
  # for

  str_chars.each_with_index do |val, i|
    if val == substr[0]
      match_start = i
      j = i + 1
      for value in 1..(substr.length - substr.length) do
        if str[j] == substr[value]
          flag = 1
          j = j + 1
        else 
          flag = 0
          break
        end
      end

      if flag == 1
        match_index << match_start
      end
    end
  end 
  
  p match_index
end

substring_match('abcdefdbcxmbcdlo', 'bcd')


# [Unit]
# Description=bamboo-agent-android daemon
# After=docker.service
# Requires=docker.service

# [Service]
# User=root
# EnvironmentFile=/etc/environment
# Restart=always
# StartLimitInterval=200
# StartLimitBurst=6
# RestartSec=20
# ExecStartPre=-/usr/bin/docker kill bamboo-agent-android
# ExecStartPre=-/usr/bin/docker rm bamboo-agent-android
# ExecStartPre=/usr/bin/docker pull registry.bookmyshow.org/supporting/bamboo-agent:6.10.3
# ExecStart=/usr/bin/docker run --net=host \
#         --name bamboo-agent \
#         -h bamboo-agent-4.sit.n3b.bookmyshow.org \
#         -e TIER=sit \
#         -e DC=sit \
#         -e BAMBOO_SERVER="bamboo-1.bookmyshow.org" \
#         -e DOCKER_LOGIN_USERNAME="admin" \
#         -e DOCKER_LOGIN_PASSWORD="Bigtree@1234" \
#      \
#  \
#  \
#  -p 80:80   --mount type=bind,source="/root/.ssh/id_rsa",target="/root/.ssh/id_rsa",readonly  --mount type=bind,source="/root/.kube/config",target="/root/.kube/config",readonly \
#   --mount type=bind,source="/data/bamboo-agent-home/bamboo-agent.cfg.xml",target="/data/bamboo-agent-home/bamboo-agent.cfg.xml" \
#   -v /data/bamboo-agent-home:/data/bamboo-agent-home  -v /var/run/docker.sock:/var/run/docker.sock \
# registry.bookmyshow.org/supporting/bamboo-agent:6.10.3
# ExecStop=/usr/bin/docker stop bamboo-agent
# PIDFile=/var/run/bamboo-agent.pid

# [Install]
# WantedBy=multi-user.target

