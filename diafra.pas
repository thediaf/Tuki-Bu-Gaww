
        // Diafra Cheikhou Soumare  LPGI1

PROGRAM Tuki_Bu_Gaw;
    uses crt;
    type 
        t_services=(p, d, c);
        t_vehicule= record
                numMat: integer;
                categorie: string;
            end;
        t_date= record
                    jours: string;
                    jour: 1..31;
                    mois: 1..12;
                    annee: integer;
                    heure: 0..23;
                    minutes: 0..59;
                end;                                 
        t_client= record
                nom: string[15];
                prenom: string[20];
                vehicule: t_vehicule;
            end;
    (*    t_details= record
                client: array[1..1000] of t_client;
                abonne: array[1..1000] of t_abonne;
                heure: string;
                jour: (lundi, mardi, mercredi, jeudi, vendredi, samedi);
            end;*)
        t_parking= record
                    nom: string[15];
              end;            
        t_depannage= record
                        probleme: string;
                    end;
        t_abonne= record
                client: t_client;
                montant: longint;
            end;             
        t_ticket= record
                    date: t_date;
                    num: string[15];
                    distance:string[3];
                    categorie: string;
                    prix: integer;
                //    choix: string;
                    case  services: t_services of
                        p: (park:t_parking);
                        d: (panne:t_depannage);
                        c:();
                end;               
        autoroute= record
                    vehicule:t_vehicule;
                    date:t_date;
                    distance:string[3];
                    case  services: t_services of
                        p: (park:t_parking);
                        d: (panne:t_depannage);
                    //    c: (gare:t_peage); 
            end;
        gestionTickets= file of t_ticket;
        fAbonnes= file of t_abonne;
        fichierAurt= file of autoroute; 
    var 
        serv, nom: string;
        g: gestionTickets;
        h: fAbonnes;
        a: t_abonne;
        t: t_ticket;
        at:autoroute;
       f: fichierAurt; 
    procedure creationFTickets(var g: gestionTickets);
        var 
            choix,rep: char;
        begin
            Assign(g, 'H:\projet autoroute\tickets.dta');
            rewrite(g);
            repeat
                writeln;
                write('    Donnez le jour de la semaine   :   ');
                readln(t.date.jours);
                write('    Donnez la date    :     ');
                readln(t.date.jour);
                write('    Donnez le mois    :     ');
                readln(t.date.mois);
                write('    Donnez l''annee   :     ');
                readln(t.date.annee);
                write('    Donnez l''heure   :    ');
                readln(t.date.heure);
                write('    Donnez les minutes   :   ');
                readln(t.date.minutes);
                write('    Donnez le numero du ticket   :   ');
                readln(t.num);
                write('    Donnez la distance    :     ');
                readln(t.distance);   
                write('    Vous creez le ticket de quel service     : (p)arking, (d)epannage, (c)peage  :     ');
                readln(choix);
                case choix of 
                    'p': begin
                            t.prix:= 1000;
                            write('     Donnez le nom du parking   :   ');
                            readln(t.park.nom);
                            nom:=t.park.nom;
                        end;    
                    'd': begin
                            t.prix:= 5000; 
                            write('     Quel est le probleme    :   '); 
                            readln(t.panne.probleme);
                            nom:=t.panne.probleme;
                        end
                    else    
                    begin
                        if t.distance= 'ab' then
                            t.prix:=500
                        else if t.distance= 'bc' then
                            t.prix:=1000
                        else if t.distance= 'cd' then
                            t.prix:= 1500  
                        else
                            t.prix:=0;       
                        nom:= 'Peage';    
                    end;        
                end;                      
                write(g,t); writeln;
                write('     Voulez-vous saisir un autre ticket   o/n  :      ');
                readln(rep);
            until(upcase(rep)='N' );
            close(g);        
        end;
    procedure affichageDesTickets(var g: gestionTickets);
        begin
                             
            Assign(g, 'H:\projet autoroute\tickets.dta');
            reset(g);
            while not(eof(g)) do
                begin
                    read(g,t);
                    writeln;
                    writeln('-----------------------------------------------------------------------------------');
                    writeln('   TUKI BU GAW                ',t.date.jours,' , ',t.date.jour,'/',t.date.mois,'/',
                        t.date.annee,'   ',t.date.heure,':',t.date.minutes);  
                    writeln;                                                          
                    writeln('   N ',t.num,'                 Ligne : ',t.distance); 
                    writeln;
                    writeln('   ',nom,'                    Prix :  ', t.prix);            
                    writeln('-----------------------------------------------------------------------------------');
                end;
            close(g);    
        end;      
    procedure creationFAbonnes(var h: fAbonnes);    
        var 
            rep: char;
        begin   
            
            Assign(h, 'H:\projet autoroute\abonnes.dta');
            rewrite(h);
            repeat
                writeln;
                write('        Donnez le nom de l''abonne    :    ');
                readln(a.client.nom);
                write('        Donnez son prenom     :         ');
                readln(a.client.prenom);
                write('        Donnez la categorie de son vehicule     :    ');
                readln(a.client.vehicule.categorie);
                write('        Donnez le numero de matriculation du vehicule    :     ');
                readln(a.client.vehicule.numMat);
                write('        Donnez le montant qu''il a dans son compte   :     ');
                readln(a.montant);
                write(h,a); writeln;
                writeln;
                write('     Voulez-vous saisir un autre abonne    o/n    :     ');
                readln(rep);
            until(upcase(rep)='N');
            close(h);
        end;
    procedure affichageDesAbonnes(var h: fAbonnes);
        begin

            writeln;
            writeln('   Nom&prenom                  Categorie              Matricule                   Montant');
            Assign(h, 'H:\projet autoroute\abonnes.dta');
            reset(h);
            while not(eof(h)) do
                begin
                    read(h,a);
                    writeln;
                    writeln('   ',a.client.nom,' ',a.client.prenom,'                  ',a.client.vehicule.categorie,'                 ',
                        a.client.vehicule.numMat, '                 ', a.montant);                        
                end;
            close(h);    
        end;        
    procedure creationFAutoroute(var f:fichierAurt);
        var
            rep,choix: char;
            
        begin
            
            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            rewrite(f);
            repeat
                writeln;
                write('   Donnez le jour de la semaine       :       ');
                readln(at.date.jours);
                write('    donnez la date du jour      :    ');
                readln(at.date.jour);
                write('    Donnez le mois    :     ');
                readln(t.date.mois);
                write('    Donnez l''annee   :     ');
                readln(t.date.annee);
                write('    Donnez l''heure     :    ');
                readln(at.date.heure);
                write('    Donnez les minutes ');
                readln(at.date.minutes);
                write('   Donnez la categorie du vehicule      :     ');
                readln(at.vehicule.categorie);
                write('   Donnez son numero de matriculation    :    ');
                readln(at.vehicule.numMat);
                write('   Donnez la distance   :    ');
                readln(at.distance);
                write('   De quel service il s''agit :   (p)arking, (d)epannage, (c)peage        :      ');
                readln(choix);
                case choix of
                    'p': begin
                            write('   Donnez le nom du parking   :    ');
                            readln(at.park.nom);
                            at.services:= p;
                            serv:=at.park.nom;
                        end;
                    'd': begin     
                            write('   Quel est votre probleme     :       ');
                            readln(at.panne.probleme);
                            at.services:= d;
                            serv:= at.panne.probleme;
                        end
                    else       
                    begin
                        at.services:=c;
                        serv:= 'peage';
                    end;    
                end;
                write(f,at);     writeln;
                writeln;
                write('    Voulez-vous saisir un autre     :      ');
                readln(rep);                          
            until (upcase(rep)='N');
            close(f);
        end;
    procedure affichage(var f:fichierAurt; var g:gestionTickets; var h:fAbonnes);
        begin

            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            reset(f);
            Assign(g, 'H:\projet autoroute\tickets.dta');
            //reset(g);
            Assign(h, 'H:\projet autoroute\abonnes.dta');
            reset(h);
            while not(eof(f)) do
                begin
                    read(f,at);
                    writeln;
                    writeln('                                       ',at.date.jours,', le ',at.date.jour,'/',at.date.mois,'/',at.date.annee);
                    writeln('    Un(e) ',at.vehicule.categorie,' de matricule ',at.vehicule.numMat,' est pris la ligne ',at.distance,
                                '  a ', at.date.heure,':',at.date.minutes);
                    if (at.services= c) then   
                        writeln('   A continue sa route      ')
                    else if (at.services= d) then
                        writeln('   A ete depanne   ')
                    else
                        writeln('   Il a ete gare au parking     ');
                    while not(eof(h)) do
                    begin
                        read(h,a);
                        if a.client.vehicule.numMat=at.vehicule.numMat then 
                        begin
                        while not(eof(g)) do
                        begin
                            read(g,t);
                            if (at.date.jours=t.date.jours) and (at.date.jour=t.date.jour) and (at.date.heure=t.date.heure) and (at.date.minutes=at.date.minutes) 
                                and (nom=serv) then
                            begin
                                if (t.prix<=a.montant) then
                                begin
                                    a.montant:= a.montant-t.prix;
                                    writeln('    Son propriete est abonne et ', t.prix,' a ete tire de son compte. Il lui reste ',a.montant);
                                    
                                end
                                else
                                writeln('    Son propriete est abonne mais il n''a pas ', t.prix,' dans son compte il doit payer en liquide ');
                                writeln('      Voici son ticket    ');
                                affichageDesTickets(g);
                            end;
                        end;
                        close(g);
                        end           
                        else
                        begin
                        reset(g);
                        while not(eof(g)) do
                        begin
                            read(g,t);
                            if ((at.date.jours=t.date.jours) and (at.date.jour=t.date.jour) and (at.date.mois=t.date.mois) and   
                                     (at.date.annee=t.date.annee) and (at.date.heure=t.date.heure) and (at.date.minutes=t.date.minutes)
                                         and (nom=serv)) then
                            begin    
                                writeln('      Son propriete n''est pas abonne et il doit payer en liquide   ');
                                writeln('      Voici son ticket    ');
                                affichageDesTickets(g);
                            end;
                        end;
                        close(g);
                        end;
                    end;
                    close(h);        
                end;
            //close(g);
            //close(h);
            close(f);    
        end;  
    procedure statHoraire(var f:fichierAurt);
        var 
            y,h: integer;
        begin
            writeln;
            y:=0;
            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            reset(f);
            write(' Donnez l''heure que vous voulez voir ses nombres de frequentation   :   ');
            readln(h);
            while not(eof(f)) do    
                begin                   
                    read(f,at);
                    if at.date.heure=h then
                        y:=y+1;
                end;             
            close(f);
            writeln;
            writeln('   ',y,' vehicules ont pris l''autoroute a ', h);
        end;        
    procedure statJTravails(var f:fichierAurt);
        var
            v:integer;
        begin
            v:=0;
            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            reset(f);
            while not(eof(f)) do    
                begin   
                    read(f,at);
                    if (at.date.jours<>'samedi') and (at.date.jours<>'dimanche') then
                        v:= v+1;
                end;
            close(f);            
            writeln('   ',v,' vehicules ont pris l''autoroute pendant les jours de travail ');
            writeln;
        end;
    procedure statFeries(var f:fichierAurt);
        var
            u:integer;
        begin
            u:=0;
            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            reset(f);
            while not(eof(f)) do    
                begin   
                    read(f,at);
                    if ((at.date.jour=01) and (at.date.mois=01)) or ((at.date.jour=01) and (at.date.mois=05)) or ((at.date.jour=25) and (at.date.mois=05)) or
                        ((at.date.jour=28) and (at.date.mois=11)) then
                            u:=u+1;   
                end;         
            writeln('   ',u,' vehicules ont pris l''autoroute pendant les jours feries ');
            writeln;
        end;    
    procedure statweekend(var f:fichierAurt);
        var
            w:integer;
        begin
            w:=0;
            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            reset(f);
            while not(eof(f)) do    
                begin   
                    read(f,at);
                    if (at.date.jours='samedi') or (at.date.jours='dimanche') then
                        w:=w+1;            
                end;
            close(f);    
            writeln('   ',w,' vehicules ont pris l''autoroute pendant le week-end ');
            writeln;

        end;                
    procedure statPark(var f:fichierAurt);
        var
            u: integer;
            l: string;
            rep: char;
        begin   
            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            reset(f);
            u:=0;
            repeat
            write(' Donnez le nom du parking ');
            readln(l);
            while not(eof(f)) do    
                begin   
                    read(f,at);
                    if at.park.nom=l then 
                        u:=u+1;
                end;
            writeln;    
            writeln(u,' vehicules ont ete gare au parking ',l);    
            writeln;
            write(' Voulez-vous saisir un autre parking :   ');
            readln(rep);    
            until(upcase(rep)='N');
            close(f);
        end;
    procedure statsDepanne(var f:fichierAurt);
        var 
            l:string;
            u:integer;
        begin
            u:=0;
            write(' Donnez le nom du probleme   :   ');
            readln(l);
            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            reset(f);
            while not(eof(f)) do
                begin       
                    read(f,at);
                    if at.panne.probleme=l then
                        u:=u+1;
                end;
                writeln;
                writeln('   ',u,' vehicules avec un probleme de ', l);
                writeln;
            close(f);
        end;
        procedure statsCatV(var f:fichierAurt);
            var 
                l,m,n,o:integer;
            begin   
                l:=0;
                m:=0;
                n:=0;
                o:=0;
                Assign(f, 'H:\projet autoroute\autoroutes.dta');
                reset(f);
                while not(eof(f)) do
                begin       
                    read(f,at);
                    if at.vehicule.categorie= 'camion' then
                        l:=l+1
                    else if at.vehicule.categorie='personnel' then
                        m:=m+1
                    else if at.vehicule.categorie='moto' then
                        n:=n+1
                    else if at.vehicule.categorie='bus' then
                        o:=o+1;
                end;
                close(f);
                writeln('   ',l,' camions ont pris l''autoroute ');
                writeln('   ',m,' voitures personnels ont pris l''autoroute ');
                writeln('   ',n,' motos ont pris l''autoroute ');
                writeln('   ',o,' bus ont pris l''autoroute ');                    
            end; 
    procedure ajoutTicket(var g:gestionTickets);
        var
            choix:char;
        begin
            Assign(g, 'H:\projet autoroute\tickets.dta');
            rewrite(g);
            seek(g,filesize(g));
                writeln;
                write('    Donnez le jour de la semaine   :   ');
                readln(t.date.jours);
                write('    Donnez la date    :     ');
                readln(t.date.jour);
                write('    Donnez le mois    :     ');
                readln(t.date.mois);
                write('    Donnez l''annee   :     ');
                readln(t.date.annee);
                write('    Donnez l''heure   :    ');
                readln(t.date.heure);
                write('    Donnez les minutes   :   ');
                readln(t.date.minutes);
                write('    Donnez le numero du ticket   :   ');
                readln(t.num);
                write('    Donnez la distance    :     ');
                readln(t.distance);   
                write('    Vous creez le ticket de quel service     : (p)arking, (d)epannage, (c)peage  :     ');
                readln(choix);
                case choix of 
                    'p': begin
                            t.prix:= 1000;
                            write('     Donnez le nom du parking   :   ');
                            readln(t.park.nom);
                            nom:=t.park.nom;
                        end;    
                    'd': begin
                            t.prix:= 5000; 
                            write('     Quel est le probleme    :   '); 
                            readln(t.panne.probleme);
                            nom:=t.panne.probleme;
                        end
                    else    
                    begin
                        if t.distance= 'ab' then
                            t.prix:=500
                        else if t.distance= 'bc' then
                            t.prix:=1000
                        else if t.distance= 'cd' then
                            t.prix:= 1500  
                        else
                            t.prix:=0;       
                        nom:= 'Peage';    
                    end;        
                end;                      
                write(g,t); writeln;
                close(g);   
        end;
    procedure ajoutAbonne(var h: fAbonnes);    
         begin   
            
            Assign(h, 'H:\projet autoroute\abonnes.dta');
            rewrite(h);
            seek(h,filesize(h));
                writeln;
                write('        Donnez le nom de l''abonne    :    ');
                readln(a.client.nom);
                write('        Donnez son prenom     :         ');
                readln(a.client.prenom);
                write('        Donnez la categorie de son vehicule     :    ');
                readln(a.client.vehicule.categorie);
                write('        Donnez le numero de matriculation du vehicule    :     ');
                readln(a.client.vehicule.numMat);
                write('        Donnez le montant qu''il a dans son compte   :     ');
                readln(a.montant);
                write(h,a); writeln;
                close(h);
        end;    

    procedure menu();
        var
            x: integer;
        begin
            writeln('   ================================================    ');
            writeln('   ||          SOCIETE TUKI BU GAW               ||    ');
            writeln('   ================================================    ');
            repeat
                writeln('1-GESTION');
                writeln('2-STATISTIQUE');
                writeln('3-QUITTER');
                write(' Vous voulez voir la gestion ou les stats    :   ');
                readln(x);
                case x of
                1: begin
                    repeat
                        writeln('1-Gestion des tickets ');
                        writeln('2-Gestion des abonnes ');
                        writeln('3-Gestion de l''autoroute ');
                        writeln('4-Quitter ');
                        write(' Choisissez un gestion   :   ');
                        readln(x);
                        case x of 
                            1: begin
                                repeat
                                    writeln('1-Creation ');
                                    writeln('2-Affichage ');
                                    writeln('3-Ajout des tickets ');
                                    writeln('4-Quitter');
                                    write(' Vous voulez afficher ou creer :   ');
                                    readln(x);
                                    case x of 
                                        1: begin
                                            writeln;
                                            writeln('           ------------------------------------------------');
                                            writeln('           |           Creation du fichier des tickets    |');
                                            writeln('           ------------------------------------------------');
                                            creationFTickets(g);
                                        end;
                                        2: begin
                                            writeln;
                                            writeln('           ------------------------------------------------');
                                            writeln('           |                LISTES DES TICKETS            |');
                                            writeln('           ------------------------------------------------');
                                            affichageDesTickets(g);
                                        end; 
                                        3: begin
                                            writeln;
                                            writeln('           ------------------------------------------------');
                                            writeln('           |           Ajout de tickets                   |');
                                            writeln('           ------------------------------------------------');
                                            ajoutTicket(g);
                                        end;    
                                    end;
                                until (x=4);
                            end;
                            2: begin
                                repeat
                                    writeln('1-Creation ');
                                    writeln('2-Affichage ');
                                    writeln('3-Ajouter un abonner ');
                                    writeln('4-Quitter');
                                    write(' Vous voulez afficher ou creer :   ');
                                    readln(x);
                                    case x of 
                                        1: begin
                                            writeln;
                                            writeln('           ------------------------------------------------');
                                            writeln('           |         Creation du fichiers des abonnes      |');
                                            writeln('           ------------------------------------------------');
                                            creationFAbonnes(h);
                                        end;    
                                        2: begin
                                            writeln;
                                            writeln('           ------------------------------------------------');
                                            writeln('           |                LISTES DES ABONNES            |');
                                            writeln('           ------------------------------------------------');
                                            affichageDesAbonnes(h);
                                        end;    
                                        3:begin
                                            writeln;
                                            writeln('           ------------------------------------------------');
                                            writeln('           |                AJOUT D''ABONNE               |');
                                            writeln('           ------------------------------------------------');
                                            ajoutAbonne(h);
                                        end;    
                                    end;
                                until (x=4);
                            end; 
                            3: begin
                                repeat
                                    writeln('1-Creation ');
                                    writeln('2-Affichage ');
                                    writeln('3-Quitter');
                                    writeln(' Vous voulez afficher ou creer :   ');
                                    readln(x);
                                    case x of 
                                        1: begin  
                                            writeln;
                                            writeln('           ---------------------------------------------------------------');
                                            writeln('           |                 CREATION DU FICHIER DE L''AUTOROUTE         |');
                                            writeln('           ---------------------------------------------------------------');  
                                            creationFAutoroute(f);
                                        end;
                                        2: begin 
                                            writeln;
                                            writeln('           ---------------------------------------------------------------------------------');
                                            writeln('           |                AFFICHAGE DES TOUTES LES INFORMATIONS DE L''AUTOROUTE          |');
                                            writeln('           ---------------------------------------------------------------------------------');
                                            affichage(f,g,h);
                                        end;
                                    end; 
                                until (x=3);
                            end;
                        
                        end;
                    until (x=4);
                end;
                2: begin
                    writeln;
                    writeln('----------------------------------------------------');
                    writeln('|       LES STATISTIQUES DE FREQUENTATIONS         |');
                    writeln('----------------------------------------------------');
                    writeln;
                    repeat
                        writeln('1-Par tranches horaires ');
                        writeln('2-Par jours de travail  ');
                        writeln('3-Par jours feries ');
                        writeln('4-Par week-ends');
                        writeln('5-Des parkings ');
                        writeln('6-Des services de depannages');
                        writeln('7-Des voitures par categories ');
                        writeln('8-Quitter');
                        write(' Choisissez un parmi ces 8 choix ');
                        readln(x);
                        case x of 
                            1: begin
                                writeln;
                                writeln('----------------------------------------');
                                writeln('|          TRANCHES HORAIRES            |');
                                writeln('----------------------------------------');
                                writeln;
                                statHoraire(f);
                            end;
                            2: begin
                                writeln;
                                writeln('----------------------------------------');
                                writeln('|          JOURS DE TRAVAIL             |');
                                writeln('----------------------------------------');
                                writeln;
                                statJTravails(f);
                            end;
                            3: begin
                                writeln;
                                writeln('----------------------------------------');
                                writeln('|          JOURS FERIES                 |');
                                writeln('----------------------------------------');
                                writeln;
                                statFeries(f);
                            end;     
                            4: begin
                                writeln;
                                writeln('----------------------------------------');
                                writeln('|          WEEK-ENDS                    |');
                                writeln('----------------------------------------');
                                writeln;
                                statweekend(f);
                            end;
                            5:begin
                                writeln;
                                writeln('----------------------------------------');
                                writeln('|          UTILISATION DES PARKINS      |');
                                writeln('----------------------------------------');
                                writeln;
                                statPark(f);
                            end;
                            6: begin
                                writeln;
                                writeln('----------------------------------------');
                                writeln('|          SERVICES DE DEPANNAGES       |');
                                writeln('----------------------------------------');
                                writeln;
                                statsDepanne(f);
                            end;
                            7: begin
                                writeln;
                                writeln('----------------------------------------');
                                writeln('|          VOITURES PAR CATEGORIES      |');
                                writeln('----------------------------------------');
                                writeln;
                                statsCatV(f);
                            end; 
                        end;    
                    until (x=8);                            
                end;    
                3: exit;
                end;    
            until (x=3);
        end;                                                                
    BEGIN 
        writeln('           Bienvenue chez vous     ');
        writeln;     
        menu();
       
    END.    



