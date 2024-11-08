(async () => {
    let logado = await loginService.logado();
    if (logado) {
      window.location.href = "/dashboard.html";
    }
})();
  

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("formAuthentication").onsubmit = async (e) => {
        e.preventDefault();
        
        let email = document.getElementById("email").value;
        let password = document.getElementById("password").value;
        let lembrese = document.getElementById("remember-me").checked;

        let payload = {email: email, senha: password}

        try {
            const response = await fetch(`${URL_API}/login`, {
                method: 'POST', // método HTTP
                headers: {
                    'Content-Type': 'application/json' // define o tipo de conteúdo como JSON
                },
                body: JSON.stringify(payload) // converte os dados para uma string JSON
            });
        
            // Verifica se a resposta foi bem-sucedida
            if (!response.ok) {
                throw new Error(`Erro: ${response.status}`);
            }
        
            const result = await response.json(); // converte a resposta para JSON
            
            loginService.setSession(result.token, lembrese);
            window.location.href = "/dashboard.html"
        } catch (error) {
            console.error('Erro:', error); // exibe o erro no console
        }
    }
});
  