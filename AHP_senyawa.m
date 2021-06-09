nama = {'Ekky' 'Ramadhan' 'Rega' 'Agassi' };
data = [ 180	100	30
         120	80	50
         199	77	19
         150	22	33
         
];
     
maxKualitasSatu = 200;  %Kualitas Asam Sulfat
maxKualitasDua = 100;   %Kualitas Asam Klorida
maxKualitasTiga = 50;   %Kualitas Asam Nitrat

data(:,1) = data(:,1) / maxKualitasSatu;
data(:,2) = data(:,2) / maxKualitasDua;
data(:,3) = data(:,3) / maxKualitasTiga;

relasiAntarKriteria = [ 1 0.5 0.25
                        0 1 0.5
                        0 0 1];
                    
TFN = {[-100/3 0 100/3]     [3/100 0 -3/100]
       [0 100/3 200/3]      [3/200 3/100 0 ]
       [100/3 200/3 300/3]  [3/300 3/200 3/100 ]
       [200/3 300/3 400/3]  [3/400 3/300 3/200 ]};
   
 [RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria);
 
 if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);
    % Hitung nilai skor akhir
    ahp = data * bobotAntarKriteria';
    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('Nama Peneliti, Skor Akhir, Kesimpulan')
 end
 
     for i = 1:size(ahp, 1)
        if ahp(i) < 0.5
            status = 'Kurang';
        elseif ahp(i) < 0.6
            status = 'Cukup';
        elseif ahp(i) < 0.8
            status = 'Baik';
        else
            status = 'Sangat Baik';
        end
        disp([char(nama(i)), blanks(14 -cellfun('length',nama(i))), ', ', ...
            num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ...
            char(status)])

     end