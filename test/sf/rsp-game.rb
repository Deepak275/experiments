def winner(user_input)
    winner_map  = {'r': 's', 'p': 'r', 's': 'p'}

    puts "Please enter your choice(r=rock, p=paper, s=scissor)"
    user_input = gets.chomp

    puts comp_input = ['r','p','s'].shuffle.first


    if user_input == comp_input 
        return puts "Draw!"
    end

    if user_input ==  winner_map[comp_input]
        return puts  "user won!"
    end    

    puts "computer won!"
end


winner('r')

script {    
    // def response = ""
    sh 'echo "Calling bot-engine"'
    response = sh(script: '''\
    curl -s -o res.txt -w '%{http_code}' --location --request GET "https://test-api.free.beeceptor.com/admin/health\?file\=aicc-balance\&token\=b8fbd106-a0e6-4611-af33-6218886a0f9f" --header 'Authorization: Bearer e680e668-363f-4c5f-90ff-44fcd1e3a84e'  -vv  \
    ''', returnStdout: true)
    
    
    partial_failure = sh(script: '''cat res.txt | grep issue | echo $?''', returnStdout: true)
    
                        
    sh 'cat res.txt'
    response_body = sh(script: 'cat res.txt', returnStdout: true)
    // echo $response
    
    
    // '''+res+'''= $response
    // env.MES = $response
    if ("${response}" == "200") {
        if ("${partial_failure}" == 0) {
            println("Test has failed, please fix those and try again");
            sh 'exit 1'
        }
        // sh 'exit 1'
    } else { 
        //If the condition is false print the following statement 
        println("Test has failed, please fix those and try again");
        pritln ${response_body}
        sh 'exit 1'
     } 
}
