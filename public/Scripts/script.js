const searchInput = document.getElementById('searchInput');
const searchResults = document.getElementById('searchResults');


async function search(searchTerm) {
    searchResults.innerHTML = ''; 

    if (!searchTerm.trim()) {
        const li = document.createElement('li');
        li.textContent = 'Por favor, ingrese un término de búsqueda.';
        searchResults.appendChild(li);
        return;
    }

    try {
        const response = await fetch(`/soluciones?keyword=${encodeURIComponent(searchTerm)}`);
        const results = await response.json();

        if (results.length === 0) {
            const li = document.createElement('li');
            li.textContent = 'No se encontraron soluciones para el término ingresado.';
            searchResults.appendChild(li);
            return;
        }

        results.forEach(item => {
            const li = document.createElement('li');
            li.innerHTML = `
                <strong>${item.nombre}</strong><br>
                <p>${item.descripcion}</p>
                <a href="${item.enlace}" target="_blank">Sitio oficial</a>
            `;
            searchResults.appendChild(li);
        });
    } catch (err) {
        console.error('Error al buscar soluciones:', err);
        const li = document.createElement('li');
        li.textContent = 'Ocurrió un error al buscar soluciones. Intente nuevamente más tarde.';
        searchResults.appendChild(li);
    }
}


searchInput.addEventListener('keyup', (event) => {
    if (event.key === 'Enter') {
        search(searchInput.value);
    }
});
