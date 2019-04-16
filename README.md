# **Provider** service description

- [**Provider** service description](#provider-service-description)
    - [Idea](#idea)
    - [Components](#components)
        - [Item](#item)
        - [Separator](#separator)
        - [Button](#button)
    - [Screen](#screen) 
    
## Idea
>>>
Приложение состоит из набора экранов (screen). Каждый экран описывается в виде джейсона, который приходит в ответе на запрос.
Экран содержит список компонент и кнопок.

Сервер покрыт авторизацией.
>>>

## Components

### Item
>>>
Ссылка на модель данных компоненты

Макет компоненты

![image](images/item.png)

#### Conditions
```kotlin
1. if (picture = null)
    "key" сдвигать на место "picture"
2. if (edit == "true")
    "key" and "value" отображать ярким цветом
   else
    "key" and "value" отображать тусклым цветом
3. if (request != null)
    после "value" отображать знак ">"
4. При нажатии на компоненту, по значению поля "request" отправляется запрос на получение экрана (screen)
5. Зависимость отображения "value" от поля "typeValue" смотри в таблице ниже
```
Таблица зависимости отображения "value" от поля "typeValue"

typeValue | отображение "value"
--------- | -----
switch    | ![image](images/switch.png)
date      | ![image](images/date.png)
>>>

### Separator
>>>
Ссылка на модель данных компоненты

Таблица зависимости отображения "separator" от поля "type"
>>>

### Button
>>>
Ссылка на модель данных компоненты

Таблица зависимости отображения "button" от поля "type"

#### Conditions
1. Кнопка становится доступной для нажатия при выполнении условий поля "able", иначе отображается недоступной 
1. При нажатии кнопки
    ```kotlin
    if (type = "back")
        осуществляется переход на предыдущий экран
    else if (request != null)
        по значению поля "request" отправляется запрос на получение экрана (screen)
    ```
>>>

## Screen
>>>
Ссылка на модель данных экрана

Макет экрана

### Conditions
1. Порядок отображения компонент соответствует порядку в списке "components"
1. Порядок отображения кнопок внизу экрана соответствует порядку в списке "button" 
>>>