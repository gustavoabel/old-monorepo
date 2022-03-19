import React, { useCallback, useEffect, useState } from 'react';

import { Tooltip, usePage } from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { SequenceScenario } from '../../types/SequenceScenario';
import { UnitSequenceSum } from '../../types/UnitSequence';
import { Container, StyledIcon, TooltipContainer } from './styles';
interface TableTitleProps {
  unitName: string;
}

const TableTitle = ({ unitName }: TableTitleProps) => {
  const { masterItem } = usePage('masterItem');
  const Scenario = masterItem as SequenceScenario;
  const [tooltipContent, setTooltipContent] = useState<UnitSequenceSum>();
  const handleAttributeInfo = useCallback(
    async (visible: boolean) => {
      if (visible) {
        const { ok, data } = await pssApi.getSumByUnitSequence({ params: { unitName, scenarioId: Scenario.id } });
        if (ok) {
          setTooltipContent(data);
        }
      }
    },
    [Scenario?.id, unitName],
  );

  // useEffect(() => {
  //   if (unitName) {
  //     // fazer a chamada da api.
  //     const { ok, data } = pssApi.getSumByUnitSequence({ params: { unitName, scenarioId: Scenario.id } });

  //     setTooltipContent(retornoDaApiMock);
  //   }
  // }, [unitName]);

  const StyledTooltip = () => {
    return (
      <>
        {tooltipContent && (
          <TooltipContainer>
            <div>
              Total Weight: <span>{tooltipContent.sumOfLength}</span>
            </div>
            <div>
              Total Length: <span>{tooltipContent.sumOfWeight}</span>
            </div>
          </TooltipContainer>
        )}
      </>
    );
  };

  return (
    <Container>
      {unitName}
      <Tooltip title={StyledTooltip} placement="right" onVisibleChange={handleAttributeInfo}>
        <StyledIcon name="info-circle" />
      </Tooltip>
    </Container>
  );
};

export default TableTitle;
