def getAccountID(String environment){
    switch(environment) { 
        case 'dev': 
            return "419885643439"
        case 'qa':
            return "419885643439"
        case 'uat':
            return "419885643439"
        case 'pre-prod':
            return "419885643439"
        case 'prod':
            return "419885643439"
        default:
            return "nothing"
    } 
}