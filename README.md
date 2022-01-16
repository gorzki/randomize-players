### Configuration
> RVM [Instalacja](https://rvm.io/rvm/install) \
> Ruby 3.0.2 (rvm install ruby-3.0.2)\
> Rails 7.0.1 (gem install rails-7.0.1)


### Pierwsze uruchomienie
1. Po zainstalowaniu `rvm` wybierz ruby-3.0.2 (rvm use)
2. bundle install
3. rails s

### Informacje ogólne
Ogólnie to do rozwiązania tego zadania używanie framework'a jest jak:
<a href="https://www.fotosik.pl/zdjecie/0da4940f651bde42" target="_blank"><img src="https://images89.fotosik.pl/566/0da4940f651bde42med.jpg" border="0" alt="" /></a>

> Aby podejrzeć wysłane maile wystarczy wejść na `/letter_opener` np `http://localhost:3000/letter_opener/`

**Ale żeby pokazać Railsy i jego patterny rozbiłem to w ten sposób.**
1. [__SolitaireController__](https://github.com/gorzki/randomize-players/blob/main/app/controllers/solitaire_controller.rb) - zarządzanie requestami od klienta.
    1) `new` - wyrenederowanie formularza `SolitaireForm` przyjęcia pliku
    2) `create` - wywołanie formularza `SolitaireForm` z metodą `valid?` oraz obsłużenie wyniku wywołania tej metody
        1) true - wywołanie `SolitaireService` który wykona zadania z opisu klienta, następnie poprzez turbo_stream wyrenederowanie linku do pobrania pliku `.txt`
        2) false - ponowne wyrenderowanie forlumarza z informacją o błędach
    3) `download_output` - pobranie pliku output z serwera
        1) plik istnieje - zostanie zwrócony plik txt
        2) plik nie istnieje - zostanie zwrocony komunikat ze statusem 404
2. [__SolitaireForm__](https://github.com/gorzki/randomize-players/blob/main/app/form_objects/solitaire_form.rb) - formularz sprawdzający pliku wysłany przez klienta (informuje o potencjalnych błędach)
    1) `validate`
        1) zwrócenie błędu jeżeli plik nie został przesłany
        2) zwrócenie błędu jeżeli przesłany plik ma zły format
3. [__SolitaireService__](https://github.com/gorzki/randomize-players/blob/main/app/services/solitaire_service.rb) - serwis zarządzający plikiem wysłanym przez klienta
    1) `call` - wywołąnie wszystkich metod wymaganych przez klienta
    2) `players` - przeparsowanie pliku klienta na format `json` oraz utworzenie obiektów ze struktury pliku. `SolitairePlayerObject`
    3) `draw` - wylosowanie par pojedynków zawodników `Solitiare::DrawPairsCommand`
    4) `send_emails` - wysłanie emaili do zawodników `Solitaire::SendEmailCommand`
    5) `generate_output_file` - wygenerowanie pliku z informacjami o parach przeciwników dla klienta `Solitaire::GenerateOutputCommand`
4. [__SolitairePlayerObject__](https://github.com/gorzki/randomize-players/blob/main/app/value_objects/solitaire_player_object.rb) - obiekt reprezentujący sturkturę zawdonika z pobranego pliku
5. [__Solitaire::DrawPairsCommand__](https://github.com/gorzki/randomize-players/blob/main/app/commands/solitaire/draw_pairs_command.rb) - komenda do obsługi losowania par, losuje pary przeciwników dla zawodników
6. [__Solitaire::SendEmailCommand__](https://github.com/gorzki/randomize-players/blob/main/app/commands/solitaire/send_email_command.rb) - komenda do obsługi mailera, zajmuje się wysłaniem emaili dla wylosowanych par
7. [__Solitaire::GenerateOutputCommand__](https://github.com/gorzki/randomize-players/blob/main/app/commands/solitaire/generate_output_command.rb) - komenda do wygenerowania pliku txt z informacją o rozlosowanych parach
8. [__ApplicationMailer__](https://github.com/gorzki/randomize-players/blob/main/app/mailers/application_mailer.rb) - plik do konfiguracji wiadomości email
    1) `solitaire_game` - wysyła wiadomości do gracza z informacją o przeciwniku


### Inne sposoby wywołania

1. Poprzez konsolę
    1) rails c
    2) `file = scieżka do pliku` np `file = Rails.root.join('tmp', 'gamers-odd.json')`
    3) `service = SolitaireService.new(file).call`
    4) `service.output_file` lub wejscie w katalog `tmp` gdzie będzie znajdował się wygenerowany plik
2. rake task
    1) `rake solitaire:generate_game'[file]'` np `rake solitaire:generate_game'[gamers-odd.json]'`

### .env
1. cp `.env.sample .env`
2. Uzupełnij ręcznie klucze w pliku `.env`

### Konfiguracja SMTP
1) W trybie produkcyjnym aplikacja wysyła e-mail'e wykorzystując protokół SMTP. Wystarczy uzupełnić plik [production.rb](https://github.com/gorzki/randomize-players/blob/main/config/environments/production.rb)
