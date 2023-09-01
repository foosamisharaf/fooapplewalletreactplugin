import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'fooapplewalletreactplugin' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const Fooapplewalletreactplugin = NativeModules.Fooapplewalletreactplugin
  ? NativeModules.Fooapplewalletreactplugin
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

    export function setHostName(hostName: string , path:string): Promise<string> {
      return Fooapplewalletreactplugin.setHostName(hostName , path);
    }
    export interface CardUserIdDetails {
        userId?: string | null;  // nullable from "nullable NSString"
        deviceId?: string | null; // nullable from "nullable NSString"
        cardId: string;
        cardHolderName: string;
        cardPanSuffix: string;
        sessionId?: string | null; // nullable from "nullable NSString"
        localizedDescription?: string | null;
     
    
    }
    export interface CardPanIdDetails {
        userId?: string | null;  // nullable from "nullable NSString"
        deviceId?: string | null; // nullable from "nullable NSString"
        cardId: string;
        cardHolderName: string;
        cardPanSuffix: string;
        localizedDescription?: string | null; // nullable from "nullable NSString"
        pan: string;
        expiryDate: string;
    
    }
    export function addCardForUserId({userId , deviceId , cardId , cardHolderName , cardPanSuffix , sessionId,localizedDescription }:CardUserIdDetails): Promise<string> {
      return Fooapplewalletreactplugin.addCardForUserId(userId , deviceId , cardId , cardHolderName , cardPanSuffix , sessionId,localizedDescription);
    }
    export function addCardForPanId({userId , deviceId , cardId , cardHolderName , cardPanSuffix , localizedDescription , pan , expiryDate}:CardPanIdDetails): Promise<string> {
      return Fooapplewalletreactplugin.addCardForUserIdWithPanAndExpiry(userId , deviceId , cardId , cardHolderName , cardPanSuffix , localizedDescription , pan , expiryDate);
    }
    export function deviceSupportsAppleWallet (): Promise<boolean> {
      return Fooapplewalletreactplugin.deviceSupportsAppleWallet();
    }
    export function isCardAddedToLocalWalletWithCardSuffix (cardSuffix:string): Promise<boolean> {
      return Fooapplewalletreactplugin.isCardAddedToLocalWalletWithCardSuffix(cardSuffix);
    }
    export function isCardAddedToRemoteWalletWithCardSuffix (cardSuffix:string): Promise<boolean> {
      return Fooapplewalletreactplugin.isCardAddedToRemoteWalletWithCardSuffix(cardSuffix);
    }
