const KEY_LOGIN = "desafio_elixir_adm_login"

const loginService = {
    setSession: (token, lembrese) => {
        const expiracao = new Date();
        expiracao.setHours(expiracao.getHours() + 7);
    
        localStorage.setItem(KEY_LOGIN, JSON.stringify({
            token: token,
            expiracao: expiracao,
            lembrese: lembrese
        }))
    },
    getSession: () => {
        let login = localStorage.getItem(KEY_LOGIN)
        if(!login) return null
    
        login = JSON.parse(login)
    
        if( new Date(login.expiracao) > new Date()){
            return login;
        }
    
        if( !login.lembrese && new Date(login.expiracao) < new Date()){
            loginService.removeSession();
            return null;
        }
    
        if( login.lembrese && new Date(login.expiracao) < new Date()){
            return login;
        }
    },
    removeSession: () => {
        localStorage.removeItem(KEY_LOGIN)
    },
    token: () => {
        const token = loginService.logado()
        if(token) return token;
        else window.location.href = "/"
    },
    logado: async () => {
        let login = loginService.getSession()
    
        if( ! login ) return false
        if( new Date(login.expiracao) > new Date()) return login.token
    
        if( login.lembrese && new Date(login.expiracao) < new Date()){
            try {
                const response = await fetch(`${URL_API}/refresh_token`, {
                    method: 'GET', // método HTTP
                    headers: {
                        'Content-Type': 'application/json', // define o tipo de conteúdo como JSON
                        'Authorization': `Bearer ${login.token}`
                    }
                });
            
                // Verifica se a resposta foi bem-sucedida
                if (!response.ok) {
                    throw new Error(`Erro: ${response.status}`);
                }
            
                const result = await response.json(); // converte a resposta para JSON
                
                loginService.setSession(result.token, login.lembrese)
                return result.token
            } catch (error) {
                console.error('Erro:', error); // exibe o erro no console
                loginService.removeSession()
                return false
            }
        }
        else{
            return false
        }
    }
}