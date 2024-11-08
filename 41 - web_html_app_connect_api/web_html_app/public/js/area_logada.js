(async () => {
    let logado = await loginService.logado();
    if (!logado) {
      window.location.href = "/";
    }
})();
  