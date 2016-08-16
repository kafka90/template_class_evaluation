function Category(value) {
  this.value = value;
  this.length = 0;
}

function addCategory(category, value) {
  category[category.length] = new Category(value);
  category.length++;
}

var category = new Category();

addCategory(category, "교양");
addCategory(category[0], "인성");
addCategory(category[0][0], "전체");
addCategory(category[0][0], "성균논어");
addCategory(category[0][0], "인성고전");
addCategory(category[0], "리더십");
addCategory(category[0][1], "전체");
addCategory(category[0][1], "실천리더십");
addCategory(category[0][1], "이론리더십");
addCategory(category[0], "기본영어");
addCategory(category[0][2], "전체");
addCategory(category[0][2], "영어발표");
addCategory(category[0][2], "영어쓰기");
addCategory(category[0], "전문영어");
addCategory(category[0][3], "전체");
addCategory(category[0][3], "고급영어쓰기");
addCategory(category[0][3], "문예영어");
addCategory(category[0][3], "법률영어");
addCategory(category[0][3], "비즈니스영어");
addCategory(category[0][3], "스포츠영어");
addCategory(category[0][3], "시사영어");
addCategory(category[0][3], "영어토론");
addCategory(category[0], "글로벌문화");
addCategory(category[0][4], "전체");
addCategory(category[0], "의사소통");
addCategory(category[0][5], "전체");
addCategory(category[0][5], "스피치와토론");
addCategory(category[0][5], "창의적글쓰기");
addCategory(category[0][5], "학술적글쓰기");
addCategory(category[0], "창의와사유");
addCategory(category[0][6], "전체");
addCategory(category[0], "기초인문사회과학");
addCategory(category[0][7], "전체");
addCategory(category[0][7], "경제학입문");
addCategory(category[0][7], "기초독어1");
addCategory(category[0][7], "기초러시아어1");
addCategory(category[0][7], "기초일본어1");
addCategory(category[0][7], "기초일본어2");
addCategory(category[0][7], "기초중국어1");
addCategory(category[0][7], "기초프랑스어1");
addCategory(category[0][7], "기초한문");
addCategory(category[0][7], "동양사상입문");
addCategory(category[0][7], "문학입문");
addCategory(category[0][7], "사회학입문");
addCategory(category[0][7], "심리학입문");
addCategory(category[0][7], "언어학입문");
addCategory(category[0][7], "역사학입문");
addCategory(category[0][7], "정치학입문");
addCategory(category[0][7], "철학입문");
addCategory(category[0][7], "희랍어");
addCategory(category[0], "기초자연과학");
addCategory(category[0][8], "전체");
addCategory(category[0][8], "고급미분적분학1");
addCategory(category[0][8], "고급생명과학1");
addCategory(category[0][8], "공학수학1");
addCategory(category[0][8], "공학수학2");
addCategory(category[0][8], "공학컴퓨터프로그래밍");
addCategory(category[0][8], "미분적분학1");
addCategory(category[0][8], "미분적분학2");
addCategory(category[0][8], "미분적분학실습1");
addCategory(category[0][8], "생명과학1");
addCategory(category[0][8], "생명과학실험1");
addCategory(category[0][8], "선형대수학");
addCategory(category[0][8], "이산수학");
addCategory(category[0][8], "일반물리학1");
addCategory(category[0][8], "일반물리학실험1");
addCategory(category[0][8], "일반화학1");
addCategory(category[0][8], "일반화학실험1");
addCategory(category[0][8], "프로그래밍기초와실습");
addCategory(category[0][8], "확률및통계");
addCategory(category[0], "인간/문화");
addCategory(category[0][9], "전체");
addCategory(category[0], "사회/역사");
addCategory(category[0][10], "전체");
addCategory(category[0], "자연/과학/기술");
addCategory(category[0][11], "전체");
addCategory(category[0], "기타교양");
addCategory(category[0][12], "전체");


function initForm(form) {
  form.dept.length = category.length;
  for (i = 0; i < category.length; i++)
    form.dept[i].text = category[i].value;
  form.dept.selectedIndex = 0;
  form.division.selectedIndex = 0;
  change_dept(form);
}


function change_dept(form) {
  var i = form.dept.selectedIndex;
  form.division.length = category[i].length;
  for (j = 0 ; j < form.division.length; j++)
    form.division[j].text = category[i][j].value;
  form.division.selectedIndex = 0;
  change_division(form);
}


function change_division(form) {
  var i = form.dept.selectedIndex
  var j = form.division.selectedIndex;
  form.name.length = category[i][j].length;
  for (k = 0; k < form.name.length; k++)
    form.name[k].text = category[i][j][k].value;
  form.name.selectedIndex = 0;
}