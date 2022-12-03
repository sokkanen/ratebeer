const BREWERIES = {};

const handleResponse = (breweries) => {
    console.log(breweries)
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createTableRow = (brewery) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const name = tr.appendChild(document.createElement("td"));
  name.innerHTML = brewery.name;
  const year = tr.appendChild(document.createElement("td"));
  year.innerHTML = brewery.year;
  const active = tr.appendChild(document.createElement("td"));
  active.innerHTML = brewery.active ? 'Yes' : 'No';
  const beers = tr.appendChild(document.createElement("td"));
  beers.innerHTML = brewery.beers.length;

  return tr;
};

BREWERIES.show = () => {
  const oldRows = document.getElementsByClassName("tablerow")
  while (oldRows.length > 0) {
    oldRows[0].parentNode.removeChild(oldRows[0]);
  }
  const table = document.getElementById("brewerytable");

  BREWERIES.list.forEach((brewery) => {
    const tr = createTableRow(brewery);
    table.appendChild(tr);
  });
};

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortByYear = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year > b.year ? 1 : -1;
  });
};

BREWERIES.sortByActive = () => {
    BREWERIES.list.sort((a, b) => {
        return a.active < b.active ? 1 : -1;
      });
};

BREWERIES.sortByABeers= () => {
    BREWERIES.list.sort((a, b) => {
        return a.beers.length < b.beers.length ? 1 : -1;
      });
};
  
const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;

  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById("founded").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByYear();
    BREWERIES.show();
  });

  document.getElementById("active").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByActive();
    BREWERIES.show();
  });

  document.getElementById("beers").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByABeers();
    BREWERIES.show();
  });

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleResponse);
};

export { breweries };