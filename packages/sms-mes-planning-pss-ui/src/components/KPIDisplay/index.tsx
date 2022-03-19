import React, { useCallback, useEffect, useRef } from 'react';

import { Button, Icon, usePage, withComponent } from '@sms/plasma-ui';

import { useKPI } from '../..';
import { Container, KPIList, CommandsContainer, KPICard, KPIName, KPIValue } from './styles';

const KPIDisplay: React.FC = () => {
  const ListRef = useRef<HTMLDivElement>(null);
  const { itemId } = usePage('itemId');
  const { kpiList, getKpiList } = useKPI();

  const scrollKPI = useCallback(
    (scrollOffset) => {
      if (ListRef.current) {
        ListRef.current.scrollLeft += scrollOffset;
      }
    },
    [ListRef],
  );

  useEffect(() => {
    if (itemId && itemId > 0) {
      getKpiList(itemId);
    }
  }, [getKpiList, itemId]);

  return (
    <Container>
      <KPIList ref={ListRef}>
        {kpiList !== null &&
          kpiList.map((kpi) => (
            <KPICard key={kpi.label}>
              <KPIName>{kpi.label}</KPIName>
              <KPIValue>{kpi.value}</KPIValue>
            </KPICard>
          ))}
      </KPIList>
      {kpiList !== null && kpiList.length > 0 && (
        <CommandsContainer>
          <Button type="text" icon={<Icon name="chevron-left" />} onClick={() => scrollKPI(-100)} />
          <Button type="text" icon={<Icon name="chevron-right" />} onClick={() => scrollKPI(100)} />
        </CommandsContainer>
      )}
    </Container>
  );
};

export default withComponent(KPIDisplay);
