function [] = drawHangman(stageNumber)
% DRAWHANGMAN creates a figure of a hangman in stage "stageNumber"
% --- "stageNumber" is an integer


% creates border
hold on
rectangle('Position', [10 0 10 10], 'EdgeColor', 'k', 'LineWidth',5);

% adds a part of the drawing for each stageNumber
if stageNumber >= 0

    % empty

    if stageNumber >= 1
        % stand: part 1 (side)

        stage1 = line([18 18], [0 7], 'Color', 'k', 'LineWidth', 3);

        if stageNumber >= 2
            % stand: part 2 (top)

            stage2 = line([16 18], [7 7], 'Color', 'k', 'LineWidth', 3);

            if stageNumber >= 3
                % stand: part 3 (support)

                stage3 = line([17 18], [7 6], 'Color', 'k', 'LineWidth', 3);

                if stageNumber >= 4
                    % stand: part 4 (noose)

                    stage4 = line([16 16], [6 7], 'Color', 'k', 'LineWidth', 3);

                    if stageNumber >= 5
                        % person: part 5 (head)

                        headX = 16; % x-coordinate of head
                        headY = 5.5; % y-coordinate of head
                        headR = 0.5; % radius of head
                        theta = 0:pi/180:2*pi;
                        h1 = headR*cos(theta) + headX;
                        h2 = headR*sin(theta) + headY;

                        % plot head
                        stage5 = plot(h1, h2, 'Color', 'k', 'LineWidth', 3);


                        if stageNumber >= 6
                            % person: part 6 (body)

                            stage6 = line([16 16], [2 5], 'Color', 'k', ...
                                'LineWidth', 3);

                            if stageNumber >= 7
                                % person: part 7 (left leg)
                                
                                stage7 = line([15.5 16], [1 2], 'Color', ...
                                    'k', 'LineWidth', 3);

                                if stageNumber >= 8
                                    % person: part 8 (right leg)

                                    stage8 = line([16 16.5], [2 1], ...
                                        'Color', 'k', 'LineWidth', 3);

                                    if stageNumber >= 9
                                        % person: part 9 (left arm)
                                        
                                        stage9 = line([15.5 16], [3 4], ...
                                            'Color', 'k', 'LineWidth', 3);

                                        if stageNumber >= 10
                                            % person: part 10 (right arm)
                                            
                                            stage9 = line([16 16.5], [4 3], ...
                                                'Color', 'k', 'LineWidth', 3);

                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

end