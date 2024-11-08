document.addEventListener("DOMContentLoaded", async function() {
    let adms = await admService.all();

    let html = `<tbody class="table-border-bottom-0"></tbody>`;
    if (adms && adms.registros && adms.registros.length > 0) {
        html = `
            <tbody class="table-border-bottom-0">
                ${adms.registros.map(adm => `
                    <tr>
                        <td>${adm.id}</td>
                        <td>${adm.nome}</td>
                        <td>${adm.email}</td>
                    </tr>
                `).join('')}
            </tbody>
        `;
    }

    document.querySelector("#administrador-table tbody").innerHTML = html;
});
