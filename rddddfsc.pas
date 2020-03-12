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
                    jour: string;
                    heure: string;
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
                    choix: string;
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
            writeln;
            writeln('           ------------------------------------------------');
            writeln('                      Creation du fichier des tickets    ');
            writeln('           ------------------------------------------------');
            Assign(g, 'h:\projet autoroute\tickets.dta');
            rewrite(g);
            repeat
                write('    Donnez le jour de la semaine   :   ');
                readln(t.date.jours);
                write('    Donnez la date    :     ');
                readln(t.date.jour);
                write('    Donnez l''heure   :    ');
                readln(t.date.heure);
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
                            t.prix:= 1500;     
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
            writeln;
            writeln('           ------------------------------------------------');
            writeln('                           LISTES DES TICKETS         ');
            writeln('           ------------------------------------------------');
            Assign(g, 'h:\projet autoroute\tickets.dta');
            reset(g);
            while not(eof(g)) do
                begin
                    read(g,t);
                    writeln;
                    writeln('   TUKI BU GAW                 ',t.date.jours,' , ',t.date.jour,'   ',t.date.heure);  
                    writeln;                                                          
                    writeln('   N ',t.num,'                    Ligne : ',t.distance); 
                    writeln;
                    writeln(    t.choix,'                   Prix :  ', t.prix);            
                end;
            close(g);    
        end;      
    procedure creationFAbonnes(var h: fAbonnes);
        var 
            rep: char;
        begin   
            writeln;
            writeln('           ------------------------------------------------');
            writeln('                    Creation du fichiers des abonnes          ') ;
            writeln('           ------------------------------------------------');
            Assign(h, 'h:\projet autoroute\abonnes.dta');
            rewrite(h);
            repeat
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
                write(h,a);
                write('     Voulez-vous saisir un autre abonne    o/n    :     ');
                readln(rep);
            until(upcase(rep)='N');
            close(h);
        end;
    procedure affichageDesAbonnes(var h: fAbonnes);
        begin
            writeln;
            writeln('           ------------------------------------------------');
            writeln('                            LISTES DES ABONNES         ');
            writeln('           ------------------------------------------------');
            writeln;
            writeln('   Nom&prenom                  Categorie              Matricule                   Montant');
            Assign(h, 'h:\projet autoroute\abonnes.dta');
            reset(h);
            while not(eof(h)) do
                begin
                    read(h,a);
                    writeln('   ',a.client.nom,' ',a.client.prenom,'                  ',a.client.vehicule.categorie,'                 ',
                        a.client.vehicule.numMat, '                 ', a.montant);                        
                end;
            close(h);    
        end;        
    procedure creationFAutoroute(var f:fichierAurt);
        var
            rep,choix: char;
            
        begin
            writeln;
            writeln('           ---------------------------------------------------------------');
            writeln('                            CREATION DU FICHIER DE L''AUTOROUTE');
            writeln('           ---------------------------------------------------------------');
            writeln;
            Assign(f, 'h:\projet autoroute\autoroutes.dta');
            rewrite(f);
            repeat
                write('   Donnez le jour de la semaine       :       ');
                readln(at.date.jours);
                write('    donnez la date du jour      :    ');
                readln(at.date.jour);
                write('    Donnez l''heure     :    ');
                readln(at.date.heure);
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
                            serv:='parking';
                        end;
                    'd': begin     
                            write('   Quel est votre probleme     :       ');
                            readln(at.panne.probleme);
                            at.services:= d;
                            serv:= 'Depannage';
                        end
                    else       
                    begin
                        at.services:=c;
                        serv:= 'peage';
                    end;    
                end;
                write(f,at);     writeln;
                write('    Voulez-vous saisir un autre     :      ');
                readln(rep);                          
            until (upcase(rep)='N');
            close(f);
        end;
    procedure affichage(var f:fichierAurt; var g:gestionTickets; var h:fAbonnes);
        begin
            writeln;
            writeln('           ---------------------------------------------------------------------------------');
            writeln('                           AFFICHAGE DES TOUTES LES INFORMATIONS DE L''AUTOROUTE        ');
            writeln('           ---------------------------------------------------------------------------------');
            writeln;
            writeln('1');
            Assign(f, 'H:\projet autoroute\autoroutes.dta');
            writeln('2');
            reset(f);
            writeln('3');
            Assign(g, 'H:\projet autoroute\tickets.dta');
            writeln('4');
            reset(g);
            writeln('5');
            Assign(h, 'H:\projet autoroute\abonnes.dta');
            writeln('6');
            reset(h);
            writeln('6');
            while not(eof(f)) do
                begin
                    read(f,at);
                    writeln(        at.date.jours,', le ',at.date.jour);
                    writeln('    Un(e) ',at.vehicule.categorie,' de matricule ',at.vehicule.numMat,' est pris la ligne ',at.distance,
                                '  a ', at.date.heure);
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
                        while not(eof(g)) do
                        begin
                            read(g,t);
                            if (at.date.jours=t.date.jours) and (at.date.jour=t.date.jour) and (at.date.heure=t.date.heure) 
                                and (t.choix=serv) then
                            begin
                                if (t.prix<=a.montant) then
                                begin
                                    writeln('    Son propriete est abonne et ', t.prix,' a ete tire de son compte ');
                                    a.montant:= a.montant-t.prix;
                                end
                                else
                                writeln('    Son propriete est abonne mais il n''a pas ', t.prix,' dans son compte il doit payer en liquide ');
                            end;
                        end            
                        else
                        while not(eof(g)) do
                        begin
                            read(g,t);
                            if (at.date.jours=t.date.jours) and (at.date.jour=t.date.jour) and (at.date.heure=t.date.heure) 
                                and (t.choix=serv) then
                            begin    
                                writeln('      Son propriete n''est pas abonne et il doit payer en liquide   ');
                                writeln('      Voici son ticket    ');
                                affichageDesTickets(g);
                            end;
                        end;
                    end;        
                end;
            close(g);
            close(h);
            close(f);    
        end;        
    BEGIN 
       //creationFTickets(g);
        affichageDesTickets(g);
       //creationFAbonnes(h);
        affichageDesAbonnes(h);
     //  creationFAutoroute(f);
       affichage(f,g,h);
        readln;
    END.    


