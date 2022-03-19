export type MaterialMovementRequestBody = {
  moveType: 'first' | 'middle' | 'last';
  materialType: string;
  oldPosition: number;
  oldSequenceItemId?: number;
  sequenceItemId: number;
  materialId?: number;
  newPositon?: number;
};
