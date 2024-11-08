
const admService = {
    all: async () => {
        try {
            const response = await fetch(`${URL_API}/administradores`, {
                method: 'GET', // método HTTP
                headers: {
                    'Content-Type': 'application/json', // define o tipo de conteúdo como JSON
                    'Authorization': `Bearer ${await loginService.token()}`
                }
            });
        
            // Verifica se a resposta foi bem-sucedida
            if (!response.ok) {
                throw new Error(`Erro: ${response.status}`);
            }
        
            const result = await response.json(); // converte a resposta para JSON
            
            return result;
        } catch (error) {
            console.error('Erro:', error); // exibe o erro no console
            loginService.removeSession()
            return {}
        }
    },
}