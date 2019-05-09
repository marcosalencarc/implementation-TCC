
var curso = [];
var semestre = [];
var num = 0;
function adiciona() {
    var cursoInput = document.getElementById("cursoInput").value;
    var semestreInput = document.getElementById("semestreInput").value;
    if (cursoInput !== "" && semestreInput !== "" && cursoInput !== "Curso" && semestreInput !== "Semestre") {
        isRepetido = false
        for(i = 0;i < num;i++){
            if(curso[i] === cursoInput){
                isRepetido = true
            }
        }
        if(! isRepetido){
            curso[num] = cursoInput;
            semestre[num] = semestreInput;
            num++;
            document.getElementById("cursoInput").value = "Curso";
            document.getElementById("semestreInput").value = "Semestre";
        }
    }
    atualiza();

}

function atualiza() {
    var list = document.getElementById("listaCursosSemestre");
    list.innerHTML = "";
    for (i = 0; i < curso.length; i++) {
        if (curso[i] !== "") {
            list.innerHTML += '<tr><td></td><td style="width: 220px;">'+ curso[i] +'</td><td style="width: 110px;">'+ semestre[i] +'º Semestre</td><td><input type="button" value="Remover" class="btn btn-secodary btn-sm" onclick="remove('+ i +')"></td></tr>';
        }
    }
}
function remove(id) {
    curso[id] = "";
    semestre[id] = "";
    atualiza();
}