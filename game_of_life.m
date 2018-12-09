
function game_of_life(mat, number_generation, is_visual)

% основная функция программы

if is_visual
    visual(mat);
    pause(5)
else
    warning('визуализация не отображена!')
end

% основной цикл программы
for i=1:number_generation
    
    % получаем следующее поколение
    mat = getNewMat(mat);
    
    % визуализация
    if is_visual
        visual(mat);
    end
    
end

end


function countMat = calcNeighbor(m)

% функция подсчета кол-ва соседей. Каждая клетка матрицы countMat размером m x m
% отображет сумму соседей

% инициализируем новую матрицу с "бесконечными полями"
matInf = zeros(size(m)+2);

% инициализируем матрицу счета соседей
countMat = zeros(size(m,1), size(m,2));

% "замыкаем" границы

% добавляем вокруг исходной матрицы еще один слой клеток (для замыкания)
matInf(2:end-1, 2:end-1) = m;
% добавляем низ матрицы наверх нового слоя
matInf(1, 2:end-1) = m(end, :);
% добавляем вверх матрицы вниз нового слоя
matInf(end, 2:end-1) = m(1, :);
% добавляем правую сторону матрицы влево нового слоя
matInf(2:end-1, 1) = m(:, end);
% добавляем левую сторону матрицы вправо нового слоя 
matInf(2:end-1, end) = m(:, 1);

% "замыкаем" углы

% добавляем нижний правый угол в верхний левый нового слоя
matInf(1, 1) = m(end, end);
% добавляем нижний левый угол в верхний правый нового слоя
matInf(1, end) = m(end, 1);
% добавляем верхний правый угол в левый нижний нового слоя
matInf(end, 1) = m(1, end);
% добавляем верхний левый угол в правый нижний нового слоя
matInf(end, end) = m(1, 1);

[xsize, ysize] = size(m);

% получаем матрицу сумм каждой клетки
for y = 2:ysize+1
    for x = 2:xsize+1
        % считаем сумму соседей каждой клетки (узкое место программы)
        countMat(x-1, y-1) = sum(sum(matInf(x-1:x+1, y-1:y+1))) - m(x-1, y-1);
    end
end

end

function matNew = getNewMat(m)

% функция формирует новую матрицу. По правилам игры

[xsize, ysize] = size(m);

% инициализируем новую матрицу
matNew = zeros(size(m));

% получаем матрицу кол-ва соседей каждой клетки
countMat = calcNeighbor(m);

idx = 0;

% цикл по каждой клетке на поле
for yInf = 2:ysize+1
    for xInf = 2:xsize+1
        
        idx = idx + 1;

        % получаем сумму клетки
        count = countMat(idx);
        
        % ----- проходим по правилам (можно добавлять/изменять свои) -----
        
         % правило 1: Если клетка мертва и у нее 3 соседей, то в ней зарождается жизнь
        if (m(idx) == 0) && (count == 3)
            matNew(idx) = 1;
        end       
        
         % правило 2: Если клетка жива и у нее 2 или 3 соседа, то она
        % остается жить
        if (m(idx) == 1) && ((count == 2) || (count == 3))
            matNew(idx) = 1;
        end       
        
        % правило 3: Если клетка жива и у нее соседей меньше двух, то она умирает от
        % одиночества
        if (m(idx) == 1) && (count < 2)
            matNew(idx) = 0;
        end

        % правило 4: Если клетка жива и у нее больше 3 соседей, то она
        % умирает от перенаселенности
        if (m(idx) == 1) && (count > 3)
            matNew(idx) = 0;
        end
        
    end
end

end

function visual(mat)

% визуализация

spy(mat, 'b', 8)
% disp(num2str([size(mat,1), size(mat, 2)]))
% axis off;
axis equal;
% задаем оси
xlim([0 size(mat,1)])
ylim([0 size(mat,2)])
title('Game of life')

drawnow

end
