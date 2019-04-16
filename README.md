# **Provider** service description

- [**Provider** service description](#provider-service-description)
    - [Idea](#idea)
    - [Components](#components)
        - [DriverRide](#driverride)


## Idea
>>>
Приложение состоит из набора экранов (screen). Каждый экран описывается в виде джейсона, который приходит в ответе на запрос.
Каждый экран содержит список компонент в порядке их отображения и список кнопок.

Сервер покрыт авторизацией.
>>>

## Components
>>>
### Item

### Separator

### Button

## Screen


## GET../driver/rides
>>>
### Request

```kotlin
accessToken // authorization system
```

### Response

```kotlin
[DriverRide]
```

### Description

1. Из `accessToken` получает `username`
1. Из `WaterFlow` получает поездки водителя:

    ```kotlin
    GET../tasks

    select = _taskClass["Case"]driver.login[username]endStatus[null]
    ```
2.  Для каждой поездки готовит driverRide для отправки на клиент

    ```kotlin
    driverRide.
        caseId = Case.. //значения берет из аналогичных полей в Case
        orderNum = Case..
        rideNodes = Case..
        rideDateTime = Case..
        rating = accounts.getRideTrustRating(rideDateTime, Case.driver.choosingDriverDateTime) // округлить до 2х знаков после запятой
        rideClass = Case..
        maxPerson = Case..
        maxLuggage = Case..
        distance = Case..
        time = Case..
        fare = Case.driver.fare
        cleintName = Case.client.name
        statusRide = //расчет далее
    ```
3.  По данным из `WaterFlow` определяет `statusRide`: 

    ```kotlin
    GET../tasks

    select = 
    _taskClass["CheckReady"]["CheckArrive"]["CheckStart"]["CheckFinish"]_dateFinish[null]_caseId[caseId] 
    ```
    - по полученной задаче определяет `statusRide.name` согласно таблице:

        | _taskClass  | statusRide.name |
        | ----------- | --------------- |
        | CheckReady  | Ready           |
        | CheckArrive | Arrived         |
        | CheckStart  | Start           |
        | CheckFinish | Finish          |
    - если `statusRide.name` не удалось определить, то поездку полностью исключает
    - определяет поля `statusRide.active` и `statusRide.time`

        ```kotlin
        if (_dateStart > NOW) {
            active = false
            time = _dateStart - NOW
        } else {
            active = true
            time = _duration – (NOW – _dateStart)
        }
        ```
>>>

## GET../driver/market
>>>
### Request

```kotlin
accessToken // authorization system
```

### Response

```kotlin
{
  driverRides: [DriverRide]
  marketRides: [DriverRide]
}
```

### Description

1. Из `accessToken` получает `username`
2. Получает `driverRides` по `GET../driver/rides`