﻿
#Область Внешний_API
Функция ИнициализироватьПоиск(ИмяИскомогоТэга, ПутьКФайлу, ПоискПоЛокальномуИмени=Ложь, ПутьКСвойству="", Эталон="") Экспорт
	
	НовыйРазбор = Создать();
	
	НовыйРазбор.ИнициализироватьРазбор(ПутьКФайлу);
	
	Если ПутьКСвойству <> "" И Эталон <> "" Тогда
		НовыйРазбор.УстановитьВыражениеФильтра(ПутьКСвойству, Эталон);
	КонецЕсли;
	
	НовыйРазбор.НачатьПоиск(ИмяИскомогоТэга, ПоискПоЛокальномуИмени);
	
	Возврат НовыйРазбор;
	
КонецФункции
#КонецОбласти

#Область Примеры
Функция ПолучитьТекстПримера() Экспорт
	
	Текст = "ПутьКФайлу = Обработки.РазборРазметки.ПолучитьФайлТестовогоXML();
			|
			|// Будем искать тэги ""book"", у которых свойство 
			|// ""book.style"" (значение вложенного тэга или атрибута) равно ""novel"" 
			|Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск(""book"", ПутьКФайлу, Истина, ""book.style"", ""novel"");
			|
			|Пока Разбор.Следующий() Цикл
			|	
			|	ИмяАвтора 		= Разбор.ЗначениеТэга(""book.author.first-name"", Истина);
			|	ФамилияАвтора	= Разбор.ЗначениеТэга(""book.author.last-name"", Истина);
			|	
			|	Если Разбор.ЕстьТэг(""book.author.degree"") Тогда
			|		
			|		СтепениАвтора = Разбор.Тэги(""book.author.degree"");
			|		
			|		Сообщить(ИмяАвтора + "" "" + ФамилияАвтора + "" - обладатель следующих степеней:"");
			|		
			|		Для Каждого СтепеньАвтора Из СтепениАвтора Цикл
			|			
			|			Университет = СтепеньАвтора.ЗначениеАтрибута(""degree.from"");
			|			Степень		= СтепеньАвтора.ЗначениеТэга(""degree"");
			|			
			|			Сообщить(""    Университет: "" + Университет + ""; Степень: "" + Степень);
			|			
			|		КонецЦикла;
			|		
			|	Иначе
			|		
			|		Сообщить(ИмяАвтора + "" "" + ФамилияАвтора + "" не имеет степеней."");
			|		
			|	КонецЕсли;
			|	
			|КонецЦикла;";
			
	Возврат Текст;
	
КонецФункции
#КонецОбласти

#Область Тесты
Функция ПолучитьТестовыйXML() Экспорт
	
	Текст = "<?xml version=""1.0""?>
			|<?xml-stylesheet type=""text/xsl"" href=""myfile.xsl"" ?>
			|<bookstore specialty=""novel"">
			|  <book style=""autobiography"">
			|    <author>
			|      <first-name>Joe</first-name>
			|      <last-name>Bob</last-name>
			|      <award>Trenton Literary Review Honorable Mention</award>
			|    </author>
			|    <price>12</price>
			|  </book>
			|  <book style=""textbook"">
			|    <author>
			|      <first-name>Mary</first-name>
			|      <last-name>Bob</last-name>
			|      <publication>Selected Short Stories of
			|        <first-name>Mary</first-name>
			|        <last-name>Bob</last-name>
			|      </publication>
			|    </author>
			|    <editor>
			|      <first-name>Britney</first-name>
			|      <last-name>Bob</last-name>
			|    </editor>
			|    <price>55</price>
			|  </book>
			|  <magazine style=""glossy"" frequency=""monthly"">
			|    <price>2.50</price>
			|    <subscription price=""24"" per=""year""/>
			|  </magazine>
			|  <book style=""novel"" id=""myfave"">
			|    <author>
			|      <first-name>Toni</first-name>
			|      <last-name>Bob</last-name>
			|      <degree from=""Trenton U"">B.A.</degree>
			|      <degree from=""Harvard"">Ph.D.</degree>
			|      <award>Pulitzer</award>
			|      <publication>Still in Trenton</publication>
			|      <publication>Trenton Forever</publication>
			|    </author>
			|    <price intl=""Canada"" exchange=""0.7"">6.50</price>
			|    <excerpt>
			|      <p>It was a dark and stormy night.</p>
			|      <p>But then all nights in Trenton seem dark and
			|      stormy to someone who has gone through what
			|      <emph>I</emph> have.</p>
			|      <definition-list>
			|        <term>Trenton</term>
			|        <definition>misery</definition>
			|      </definition-list>
			|    </excerpt>
			|  </book>
			|  <my:book xmlns:my=""uri:mynamespace"" style=""novel"" price=""29.50"">
			|    <my:title>Who's Who in Trenton</my:title>
			|    <my:author>Robert Bob
			|	  <my:first-name>Robert</my:first-name>
			|	  <my:last-name>Bob</my:last-name>
			|	</my:author>
			|  </my:book>
			|</bookstore>";
	
	Возврат Текст;			
	
КонецФункции	

Функция ПолучитьФайлТестовогоXML() Экспорт
	
	Текст = ПолучитьТестовыйXML();
	
	Запись = Новый ЗаписьТекста;
	
	ПутьКВременномуФайлу = ПолучитьИмяВременногоФайла("xml");
	
	Запись.Открыть(ПутьКВременномуФайлу);
	
	Запись.ЗаписатьСтроку(Текст);
	
	Запись.Закрыть();
	
	Возврат ПутьКВременномуФайлу;	
	
КонецФункции

Процедура ВыполнитьТесты() Экспорт
	
	МассивТестов = Новый Массив;
	
	МассивТестов.Добавить("ПростойТест");
	МассивТестов.Добавить("СледующийБезФильтраПолныеИмена");
	МассивТестов.Добавить("СледующийБезФильтраЛокальныеИмена");
	МассивТестов.Добавить("СледующийСФильтромПолныеИмена");
	МассивТестов.Добавить("СледующийСФильтромЛокальныеИмена"); 
	МассивТестов.Добавить("ЗначениеТэгаПолныеИмена");
	МассивТестов.Добавить("ЗначениеТэгаЛокальныеИмена");
	МассивТестов.Добавить("ЗначениеАтрибутаПолныеИмена");
	МассивТестов.Добавить("ЗначениеАтрибутаЛокальныеИмена");
	МассивТестов.Добавить("ТэгиКоличествоПолныеИмена");
	МассивТестов.Добавить("ТэгиКоличествоЛокальныеИмена");
	МассивТестов.Добавить("ТэгиСодержательный");
	МассивТестов.Добавить("ЕстьТэгПолныеИмена");
	МассивТестов.Добавить("ЕстьТэгЛокальныеИмена");
	МассивТестов.Добавить("ЕстьАтрибутПолныеИмена");
	МассивТестов.Добавить("ЕстьАтрибутЛокальныеИмена");
	МассивТестов.Добавить("ТекстСодержательный");	
	
	Для Каждого Тест Из МассивТестов Цикл
		
		Попытка
			Выполнить(Тест + "()");
			Сообщить("Тест " + Тест + ": ОК");
		Исключение
			Сообщить("Тест " + Тест + ОписаниеОшибки(), СтатусСообщения.ОченьВажное);
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПростойТест()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML(), Истина, "book.style", "autobiography");
	
	Пока Разбор.Следующий() Цикл
		Если НЕ Разбор.ЗначениеТэга("book.author.last-name") = "Bob" Тогда
			ВызватьИсключение "Простой тест провалился!";
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура СледующийБезФильтраПолныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML());
	
	Количество = 0;
	
	Пока Разбор.Следующий() Цикл
		Количество = Количество + 1;		
	КонецЦикла;
	
	Если Количество <> 3 Тогда
		ВызватьИсключение "Ожидаемое количество тэгов [book]: 3, полученное: " + Количество;
	КонецЕсли;
	
КонецПроцедуры

Процедура СледующийБезФильтраЛокальныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML(), Истина);
	
	Количество = 0;
	
	Пока Разбор.Следующий() Цикл
		Количество = Количество + 1;		
	КонецЦикла;
	
	Если Количество <> 4 Тогда
		ВызватьИсключение "Ожидаемое количество тэгов [book] (сключая локальные имена): 4, полученное: " + Количество;
	КонецЕсли;
	
КонецПроцедуры

Процедура СледующийСФильтромПолныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("first-name", ПолучитьФайлТестовогоXML(), ,"first-name", "Mary");
	
	Количество = 0;
	
	Пока Разбор.Следующий() Цикл
		Количество = Количество + 1;		
	КонецЦикла;
	
	Если Количество <> 2 Тогда
		ВызватьИсключение "Ожидаемое количество тэгов [first-name] со значением ""Mary"": 2, полученное: " + Количество;
	КонецЕсли;
	
КонецПроцедуры

Процедура СледующийСФильтромЛокальныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("author", ПолучитьФайлТестовогоXML(),Истина ,"author.last-name", "Bob");
	
	Количество = 0;
	
	Пока Разбор.Следующий() Цикл
		Количество = Количество + 1;		
	КонецЦикла;
	
	Если Количество <> 4 Тогда
		ВызватьИсключение "Ожидаемое количество тэгов [author] (сключая локальные) со значением author.last-name = ""Bob"": 4, полученное: " + Количество;
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗначениеТэгаПолныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("my:book", ПолучитьФайлТестовогоXML());	
	
	Разбор.Следующий();
	
	Значение = Разбор.ЗначениеТэга("my:book.my:author.my:first-name");
	
	Если Значение <> "Robert" Тогда
		ВызватьИсключение "Ожидаемое значение тэга [my:book.my:author.my:first-name]: Robert, полученное: " + Значение;
	КонецЕсли;	
	
КонецПроцедуры

Процедура ЗначениеТэгаЛокальныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("my:book", ПолучитьФайлТестовогоXML());	
	
	Разбор.Следующий();
	
	Значение = Разбор.ЗначениеТэга("book.author.first-name", Истина);
	
	Если Значение <> "Robert" Тогда
		ВызватьИсключение "Ожидаемое значение тэга [book.author.first-name]: Robert, полученное: " + Значение;
	КонецЕсли;	
	
КонецПроцедуры

Процедура ЗначениеАтрибутаПолныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML());	
	
	Разбор.Следующий();
	Разбор.Следующий();
	Разбор.Следующий();
	
	Значение = Разбор.ЗначениеАтрибута("book.author.degree.from");
	
	Если Значение <> "Trenton U" Тогда
		ВызватьИсключение "Ожидаемое значение атрибута [book.author.degree.from]: Trenton U, полученное: " + Значение;
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗначениеАтрибутаЛокальныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML(), Истина);	
	
	Разбор.Следующий();
	Разбор.Следующий();
	Разбор.Следующий();
	Разбор.Следующий();
	
	Значение = Разбор.ЗначениеАтрибута("book.price", Истина);
	
	Если Значение <> "29.50" Тогда
		ВызватьИсключение "Ожидаемое значение атрибута [book.price]: 29.50, полученное: " + Значение;
	КонецЕсли;
	
КонецПроцедуры

Процедура ТэгиКоличествоПолныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("bookstore", ПолучитьФайлТестовогоXML());
	
	Разбор.Следующий();
	
	Значение = Разбор.Тэги("bookstore.book").Количество();
	
	Если Значение <> 3 Тогда
		ВызватьИсключение "Ожидаемое количество тэгов [book]: 3, полученное: " + Значение;
	КонецЕсли;	
	
КонецПроцедуры

Процедура ТэгиКоличествоЛокальныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("bookstore", ПолучитьФайлТестовогоXML());
	
	Разбор.Следующий();
	
	Значение = Разбор.Тэги("bookstore.book", Истина).Количество();
	
	Если Значение <> 4 Тогда
		ВызватьИсключение "Ожидаемое количество тэгов (включая локальные имена) [book]: 4, полученное: " + Значение;
	КонецЕсли;	
	
КонецПроцедуры

Процедура ТэгиСодержательный()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("bookstore", ПолучитьФайлТестовогоXML());
	
	Разбор.Следующий();
	
	МассивРазборов = Разбор.Тэги("bookstore.book", Истина);
	
	Для Каждого Тэг Из МассивРазборов Цикл
		
		Значение = Тэг.ЗначениеТэга("book.author.last-name", Истина);
		
		Если Значение <> "Bob" Тогда
			ВызватьИсключение "Ожидаемое значение всех тэгов [book.author.last-name]: Bob, полученное: " + Значение;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЕстьТэгПолныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML());	
	
	Разбор.Следующий();	
	Разбор.Следующий();
	
	ТестИстина 	= Разбор.ЕстьТэг("book.author.publication.first-name");
	ТестЛожь 	= Разбор.ЕстьТэг("book.author.publication.middle-name");
		
	Если Не ТестИстина Тогда
		ВызватьИсключение "Ожидается, что тэг [book.author.publication.first-name] существует";
	КонецЕсли;
	
	Если ТестЛожь Тогда
		ВызватьИсключение "Ожидается, что тэг [book.author.publication.middle-name] не существует";
	КонецЕсли;
	
КонецПроцедуры

Процедура ЕстьТэгЛокальныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML(), Истина);	
	
	Разбор.Следующий();	
	Разбор.Следующий();
	Разбор.Следующий();
	Разбор.Следующий();
	
	ТестИстина 	= Разбор.ЕстьТэг("book.author.first-name", Истина);
	ТестЛожь 	= Разбор.ЕстьТэг("book.author.middle-name", Истина);
		
	Если Не ТестИстина Тогда
		ВызватьИсключение "Ожидается, что тэг [book.author.first-name] существует";
	КонецЕсли;
	
	Если ТестЛожь Тогда
		ВызватьИсключение "Ожидается, что тэг [book.author.middle-name] не существует";
	КонецЕсли;
	
КонецПроцедуры

Процедура ЕстьАтрибутПолныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML());	
	
	Разбор.Следующий();	
	Разбор.Следующий();
	Разбор.Следующий();
	
	ТестИстина 	= Разбор.ЕстьАтрибут("book.author.degree.from");
	ТестЛожь 	= Разбор.ЕстьАтрибут("book.author.degree_1.from");
		
	Если Не ТестИстина Тогда
		ВызватьИсключение "Ожидается, что атрибут [book.author.degree.from] существует";
	КонецЕсли;
	
	Если ТестЛожь Тогда
		ВызватьИсключение "Ожидается, что атрибут [book.author.degree_1.from] не существует";
	КонецЕсли;
	
КонецПроцедуры

Процедура ЕстьАтрибутЛокальныеИмена()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML(), Истина);	
	
	Разбор.Следующий();	
	Разбор.Следующий();
	Разбор.Следующий();
	Разбор.Следующий();
	
	ТестИстина 	= Разбор.ЕстьАтрибут("book.style", Истина);
	ТестЛожь 	= Разбор.ЕстьАтрибут("book.style.dummy", Истина);
		
	Если Не ТестИстина Тогда
		ВызватьИсключение "Ожидается, что атрибут [book.style] существует";
	КонецЕсли;
	
	Если ТестЛожь Тогда
		ВызватьИсключение "Ожидается, что атрибут [book.style.dummy] не существует";
	КонецЕсли;
	
КонецПроцедуры

Процедура ТекстСодержательный()
	
	Разбор = Обработки.РазборРазметки.ИнициализироватьПоиск("book", ПолучитьФайлТестовогоXML());	
	
	Разбор.Следующий();	
	Разбор.Следующий();
	Разбор.Следующий();
	
	Значение = Разбор.Текст("book.excerpt.definition-list");
	
	ТестовоеЗначение = "Trenton misery";
						
	Если Значение <> ТестовоеЗначение Тогда
		ВызватьИсключение "Ожидаемое значение атрибута [book.excerpt.definition-list]: " + ТестовоеЗначение + ", полученное: " + Значение;
	КонецЕсли;
							
	
КонецПроцедуры
#КонецОбласти