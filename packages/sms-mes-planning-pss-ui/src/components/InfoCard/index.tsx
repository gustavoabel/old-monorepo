import React, { useEffect, useState } from 'react';

import { formatNumber } from '../../utils';
import { KPIName, KPIValue, CustomKPICard } from './styles';

interface Props {
  label: string;
  value: string | number;
  hasLimit?: string | number;
}

const InfoCard: React.FC<Props> = ({ label, value, hasLimit }) => {
  const [isOverLimit, setIsOverLimit] = useState<boolean>(false);

  useEffect(() => {
    if (hasLimit) {
      if (Number(value) > Number(hasLimit)) {
        setIsOverLimit(true);
      } else {
        setIsOverLimit(false);
      }
    }
  }, [hasLimit, value]);

  return (
    <>
      <CustomKPICard key={label}>
        <KPIName>{label}</KPIName>
        <KPIValue hasLimit={hasLimit ? true : false} overLimit={isOverLimit}>
          {formatNumber(value)}
        </KPIValue>
      </CustomKPICard>
    </>
  );
};

export default InfoCard;
