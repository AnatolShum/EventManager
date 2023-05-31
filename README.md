# Привет `\(username)`! 👋

Наше мобильное приложение использует встроенную базу данных, в которой содержатся ключевые события о работе пользователя с системой. Например, какие экран открываются, на какие элементы пользователь долго жмет для отображения контекстного меню и т.д. С помощью данной базы данных мы анализируем поведение пользователя и показываем какие-то подсказки, если видим что часть функционала пользователь просто не использует.

Для того, чтобы было удобнее тестировать данный функционал, мы хотим разработать отдельный подключаемый модуль, в котором можно было бы просматривать содержимое базы данных, проводить в ней поиск, добавлять и удалять записи.

Собственно суть задачи - разработать приложение, в котором можно было бы делать вышеперечисленные действия.

На гитхабе уже есть похожее решение, которое можно взять в качестве референса - [kean/Pulse](https://github.com/kean/Pulse)

# Готовы? Поехали 🚀

Итак, представим что вы вышли на стажировку и получаете подобное задание. Как и в любой другой продуктовой компании, в которую вы приходите уже есть проект, который нужно доработать. Наш случай не будет исключением 😎

Скачай и разверни у себя проект мобильного приложения - [ilia3546/EventViewerApp](https://github.com/ilia3546/EventViewerApp)

Давай проведем небольшой онбординг по проекту. Помимо стандартных AppDelegate и SceneDelegate в проекте ты найдешь следующие файлы:

- Extensions/
    - **CoreData+Utilities.swift** - набор утилит для более удобной работы с CoreData
- Entities/
    - **Event.swift** - описания объекта события. Простой struct, ничего сложного
    - **ParameterSet.swift** - кастомный словарь, где значением может быть `Int`, `String`, `Bool` или массив. Данный компонент нужен, чтобы мы могли сохранить набор параметров в базу данных.
    - **DBParameter.swift** - модель для хранения `ParameterSet` в базе данных. Простая репрезентация ParameterSet
    - **DBEvent.swift** - Простая репрезентация `Event` для хранения в базе данных
- Components/
    - **EventRegistry.swift** - перечень всех возможных событий. Удобнее когда все в одном месте :)
    - **EventManager.swift** - отвечает за взаимодействие с базой данных. Сейчас он умеет только сохранять события или проверять если какое-то событие в базе данных.
    - **EventManager+Model.swift** - описание CoreData схемы. Можно сделать и через Xcode Data Model, но мы же программисты, мы любим именно код!
- Scenes/
    - **EventsListViewController.swift** - экран со списом событий
    - **LoginViewController.swift** - экран для входа в наше приложение

На текущий момент наше приложение довольно глупое. Оно умеет только записывать события в базу, логинить и разлогинить пользователя. Давай попробуем его доработать!

### Задача 1 - Вывести список событий

🔥 **25 баллов**

И так, у нас есть экран со списком событий, но он совсем пустой. Давай попробуем заполнить его данными. Тебе нужно будет доработать EventManager таким образом, чтобы он мог отдавать список событий, отсортированных по дате срабатывания. Каждая строка таблицы должна содержать идентификатор события и время его срабатывания.

- Подсказка
    
    Используй `sortDescriptors` для того, чтобы отсортировать данные из Core Data
    

### Задача 2 - Сделай так, чтобы данные загружались порционно

🔥 **40 баллов**

Если у нас будет очень много событий и мы их попробуем вывести, у нашего приложения может просто не хватить памяти. Поэтому давай сделаем так, чтобы данные подгружались по мере скролла к концу текущей страницы.

- Подсказка
    
    Используй следующий код для того, чтобы определить когда следует загружать следующую пачку данных:
    
    ```swift
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
            self.fetchNextPage()
        }
    }
    ```
    
### Задача 3 - Удаление по свайпу (бонус-трек)*

🔥 **25 баллов**

Было бы очень здорово, если бы ты смог сделать так, чтобы можно было удалять записи сразу из списка событий по свайпу.

- Подсказка

	Используй слудующий метод для реализации:
	
	```swift
	override func tableView(
	    _ tableView: UITableView, 
	    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
	) -> UISwipeActionsConfiguration?
	```

### Задача 4 - Поиск (бонус-трек)*

🔥 **25 баллов**

Для того, чтобы мы могли найти определенное событие в списке нам бы очень пригодился поиск по идентификатору события. Поиск должен работать по всем записям в базе данных, а не только по тем, что выведены в списке.

- Подсказка

	Используй `tableView.searchController` для того, чтобы добавить поле поиска в таблицу.
	
	
### Задача 5 - Просмотр события

🔥 **50 баллов**

Итак, мы сделали кротой и удобный просмотр событий в списке. Но что, если нам нужно посмотреть на событие более детально, например какие параметры есть у данного события? Для этого нужно сделать новый экран, который мы бы показывали при нажатии на событие в списке. Что должно отображаться на данном экране:

- Идентификатор события
- Время срабатывания события
- Перечеть всех параметров события
- Кнопка для удаления события. При нажатии на данную кнопку происходит удаление события из базы данных, а пользователь возвразается обратно на экран со списком событий.

- Подсказки

	- Думаю для данного экрана отлично подойдет `UITableViewController`...
	- Для вывода перечня всех параметров можешь использовать `UITextView`, в который можно положить параметры в JSON формате. Так же можешь для каждого параметра сделать отдельную ячейку в таблице.
	
### Задача 6 - Добавление нового события (бонус-трек)*

🔥 **75 баллов**

Иногда нам требуется протестировать поведение приложения, если в базе присутствует какое-то специфическое событие. Было бы очень круто, если бы могли "руками" добавить его в базу данных.

Для этого давай добавим в экран со списком событий кнопку для добавления новой записи. При нажатии на данную кнопку у нас должен открыться экран для ввода информации о событии. Пользователю необходимо будет заполнить следующие поля:

- Идентификатор. Простое текстовое поле
- Дата / Время срабатывания события. Можешь использовать обычный `UIDatePicker` для данной цели.
- Какие-то параметры в формате "Ключ" - "Значение". Можешь использовать обычный редактируемый `UITextView` и попросить пользователя указывать данные в формате JSON =)


## Вы великолепны! 💪

Итоговый проект можешь разместить у себя на GitHub, сделать его публичным и добавить его в свое портфолио, чтобы все знали какой ты классный разработчик!