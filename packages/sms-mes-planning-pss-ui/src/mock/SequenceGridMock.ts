import { SequenceGridTypes } from '../types';

export const SequenceGrid: SequenceGridTypes.DynamicGridLayout = {
  format: 'columns',
  columns: [
    {
      rows: [
        {
          unit: {
            id: 1,
            name: 'CCM1',
          },
        },
        {
          unit: {
            id: 1,
            name: 'CCM2',
          },
        },
      ],
    },
    {
      rows: [
        {
          unit: {
            id: 3,
            name: 'HSM',
          },
        },
      ],
    },
  ],
};

export const Sequence = [
  {
    id: 1,
    name: 'Hi, One!',
  },
  {
    id: 2,
    name: 'Hi, Two!',
  },
  {
    id: 3,
    name: 'Hi, Three!',
  },
];
